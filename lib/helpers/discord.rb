# frozen_string_literal: true

# Assorted helper methods
module DiscordHelpers
  def self.debug_notification(server, message)
    puts message
    debug_channel(server).send_message(message)
  end

  def self.discord_channel(server, channel_name)
    server.channels.select { |x| x.name == channel_name }.first
  end

  def self.check_last_message(channel, msg)
    channel.history(1).first.content.include?(msg)
  end

  def self.delete_last_message(channel)
    channel.history(1).first.delete
  end

  def self.debug_channel(server)
    @debug_channel ||= discord_channel(server, "debug")
  end

  def self.game_announce(server, parser)
    
    parser.parse().each do |game, players|
      break unless players.empty? == false

      players_string = players.join(",")
      channel = discord_channel(server, game)
      msg = "**#{players_string}** have joined the server"
      channel.send_message(msg) unless check_last_message(channel, msg)
    end
  end
end
