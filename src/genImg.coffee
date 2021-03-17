{ s } = require 'koishi'

sleep = (time) -> new Promise (rev) -> setTimeout rev, time

module.exports = (browser, text) ->
  try
    page = await browser.newPage()
    await page.setContent "<pre id=\"text\">#{text}</pre>"
    element = await page.$ '#text'
    { width, height } = await element.boundingBox()
    await page.setViewport { width, height }
    img = await element.screenshot
      encoding: 'base64'
  finally
    page.close()
  return s 'image', { file: "base64://#{img}" }
