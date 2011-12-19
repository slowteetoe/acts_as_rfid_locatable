require 'serialport'
require 'json'
require 'trollop'
require 'net/http'
require 'uri'

opts = Trollop::options do
  opt :tty_port, "Serial port device name, like /dev/tty.usbserial.A4004E4P", :type => :string
  opt :location_identifier, "RFID token identifying the location", :type => :string
  opt :server_address, "DNS or IP address of server to post data to", :type => :string, :default => 'localhost'
  opt :server_port, "port of server to post data to", :type => :int, :default => 3000
  opt :server_uri, "URI for handler that will accept the JSON data", :type => :string, :default => '/trackAssets'
end

tty_devices = Dir.glob("/dev/tty.usbserial*").join(",")

Trollop::die :location_identifier, "must be a hex-encoded tag" unless /[abcdef012345678]{8,12}/i =~ opts[:location_identifier]
Trollop::die :tty_port, "must be a valid tty device, you tried to use '#{opts[:tty_port]}, possible suggestions are #{tty_devices}'" unless File.exist?(opts[:tty_port]) and File.chardev?(opts[:tty_port])

@location_identifier = opts[:location_identifier].upcase
@host = opts[:server_address]
@port = opts[:server_port]
@uri = opts[:server_uri]


def send_results(tokens)
  tokens.uniq!
  tokens.delete @location_identifier
  resp = {:tokens => tokens, :location_identifier => @location_identifier}
  
  post resp.to_json # will be something like {"tokens":["abc123","123abc"],"location_identifier":"abcdef012345678"}
end

def post(body)
  puts "Posting #{body} to #{@host} #{@port} #{@uri}"
  req = Net::HTTP::Post.new(@uri, initheader = {'Content-Type' =>'application/json'})
  req.body = body
  response = Net::HTTP.new(@host, @port).start {|http| http.request(req) }
  puts "Response #{response.code} #{response.message}: #{response.body}"
end

puts "Using #{@location_identifier} as the location identifier, listening for tag data on #{opts[:tty_port]}..."

#params for serial port  
baud_rate = 2400  
data_bits = 8  
stop_bits = 1  
parity = SerialPort::NONE  
sp = SerialPort.new(opts[:tty_port], baud_rate, data_bits, stop_bits, parity) 

tokens = []

this_token = ""
last_seen = nil

while true do
  c = sp.getc
  next if c.nil?
  case c
    when "\n"
      if tokens.include? this_token and last_seen != this_token and this_token == @location_identifier
        break	
      end
      tokens << this_token unless this_token.empty?
      puts "this token #{this_token}, last_seen #{last_seen}"
      last_seen = this_token
      this_token = ""
    when "\r"
      # ignore
    else
      this_token << c
  end
end

send_results tokens
