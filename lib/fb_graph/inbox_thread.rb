module FbGraph
  class InboxThread < Node

    attr_accessor :from, :to, :subject, :message, :updated_time, :comments, :messages
    def initialize(identifier, attributes = {})
      super
      puts attributes.inspect
      if (from = attributes[:from])
        @from = if from[:category]
          FbGraph::Page.new(from.delete(:id), from)
        elsif from[:start_time]
          FbGraph::Event.new(from.delete(:id), from)
        else
          FbGraph::User.new(from.delete(:id), from)
        end
      end
      @subject = attributes[:subject]
      
      puts "1"
      @to = attributes[:to][:data].collect do |user|
        FbGraph::User.new(user.delete(:id), user)
      end
      puts "2"

      @message = attributes.delete(:message)
      @messages = []
      if @comments = attributes.delete(:comments)
        @messages = @comments[:data].collect do |m|
          FbGraph::Message.new(m.delete(:id), m)
        end
      end
      puts "3"
      
      if (updated_time = attributes.delete(:updated_time))
        @updated_time = Time.parse(updated_time).utc
      end
      puts "4"      
    end
  end
end