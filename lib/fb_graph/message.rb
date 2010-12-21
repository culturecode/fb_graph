module FbGraph
  class Message < Node
#    include Connections::Attachments
#    include Connections::Shares
    
    attr_accessor :from, :message, :created_time

    def initialize(identifier, attributes = {})
      super
      puts "a"
      @message = attributes[:message]
      puts "b"
      @from = FbGraph::User.new(attributes[:from].delete(:id), attributes[:from])
      puts "c"
      
      if (updated_time = attributes.delete(:updated_time))
        @updated_time = Time.parse(updated_time).utc
      end
      puts "d"
    end
  end
end