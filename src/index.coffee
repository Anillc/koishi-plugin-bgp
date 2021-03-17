module.exports = (ctx, config) ->
  config = {
    dn42: 'las.awsl.ee'
    ...config
  }
  cmd = ctx.command 'bgp'
  (require './map') cmd
  (require './whois') cmd, config
#  (require './lg') cmd
