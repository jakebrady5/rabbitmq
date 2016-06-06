#!/usr/bin/env ruby
# encoding: utf-8

require 'bunny'

conn = Bunny.new(:automatically_recover => false)
conn.start

ch = conn.create_channel
q = ch.queue("hello")

begin
  puts " [*] Waiting for messages in #{q.name}. To exit press CTRL + C"
  
  q.subscribe(:block => true) do |delivery_info, properties, body|
    puts " [x] Received #{body}"
    #imitate work
    sleep body.count(".").to_i
    puts " [x] Done"
  end
  
rescue Interrupt => _
  conn.close
  exit(0)
end