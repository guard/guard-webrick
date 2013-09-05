require 'webrick'
require 'webrick/https'

module Guard
  class WEBrick
    class Server

      attr_reader :server

      def initialize(options = {})
        opt = {
          :BindAddress  => options[:host],
          :Port         => options[:port],
          :DocumentRoot => File.expand_path(options[:docroot])
        }

        if options[:quiet]
          opt = opt.merge(
            :AccessLog => [],
            :Logger => ::WEBrick::Log::new("/dev/null", 7)
          )
        end

        if options[:ssl]
          opt = opt.merge(
            :SSLEnable    => true,
            :SSLCertName  => [%w[CN localhost]]
          )
        end

        @server = ::WEBrick::HTTPServer.new opt
      end

      def start
        %w{TERM HUP}.each { |signal| trap(signal){ server.shutdown } }
        # ignore signals for guard
        %w{INT TSTP QUIT}.each { |signal| trap(signal) {} }
        @server.start
      end
    end
  end
end

if __FILE__ == $0
  host, port, ssl, docroot, quiet = ARGV
  Guard::WEBrick::Server.new(
    :host     => host,
    :port     => port,
    :ssl      => ssl == 'true',
    :quiet    => quiet == 'true',
    :docroot  => docroot
  ).start
end
