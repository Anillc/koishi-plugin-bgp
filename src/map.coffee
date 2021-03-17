{ s } = require 'koishi'

sleep = (time) -> new Promise (rev) -> setTimeout rev, time

clear = (browser, asn, v6) ->
  try
    num = if v6 then 6 else 4
    page = await browser.newPage()
    await page.goto "https://bgp.he.net/#{asn}#_graph#{num}",
      timeout: 60 * 1000
    element = await page.waitForXPath "//div[@id=\"graph#{num}\"]",
      visible: true
      timeout: 60 * 1000
    img = await element.screenshot
      encoding: 'base64'
    return s 'image', { file: "base64://#{img}" }
  finally
    page.close()

dn = (browser, asnum) ->
  try
    page = await browser.newPage()
    await page.goto 'https://nixnodes.net/dn42/graph/',
      timeout: 60 * 1000
    element = await page.waitForXPath "//*[@id=\"#{asnum}\"]",
      timeout: 60 * 1000
    await sleep 2000
    await element.click()
    await sleep 2000 # TODO
    img = await page.screenshot
      encoding: 'base64'
      fullPage: true
    return s 'image', { file: "base64://#{img}" }
  finally
    page.close()

module.exports = (cmd) ->
  cmd.subcommand '.map <asn:string>'
    .option 'dn42', '-d 查询dn42'
    .option 'v6', '-6 ipv6，该选项对dn42无效'
    .action ({session, options}, asn) ->
      {dn42, v6} = options
      res = /AS(\d+)/g.exec asn
      return '请输入正确的asn' if !res
      session.send '请稍等'
      browser = cmd.app.browser
      try
        return await clear browser, asn, v6 if !dn42
        return await dn browser, res[1]
      catch e
        return e.toString()
