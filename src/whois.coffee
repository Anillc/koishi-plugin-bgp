util = require 'util'
whois = require 'whois'

genImg = require './genImg'

lookup = util.promisify whois.lookup

module.exports = (cmd, config) ->
  cmd.subcommand '.whois <query>'
    .option 'dn42', '-d 查询dn42'
    .option 'server', '-s <server> 指定whois服务器'
    .option 'text', '-t 以文本格式输出'
    .action ({session, options}, query) ->
      {dn42, server, text} = options
      browser = cmd.app.puppeteer
      server = config.dn42 if dn42
      try
        if server
          res = await lookup query, { server }
        else
          res = await lookup query
        res = res.trim()
        return if text then res else await genImg browser, res
      catch e
        return e.toString()
