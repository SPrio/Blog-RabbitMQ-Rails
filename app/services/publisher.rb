class Publisher
  def self.publish(exchange, message = {})
    # grab the fanout exchange
    event = channel.fanout("blog.#{exchange}")
    # publish the message
    event.publish(message.to_json)
  end

  def self.channel
    @channel ||= connection.create_channel
  end

  # Bunny.new
  def self.connection
    @connection ||= Bunny.new.tap do |connect|
      connect.start
    end
  end
end
