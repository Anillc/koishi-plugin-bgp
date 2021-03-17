# koishi-plugin-bgp  

这是一个基于[koishi](https://github.com/koishijs/koishi)的机器人插件  
此插件提供了一些bgp的一些常用工具  
支持dn42查询

- [x] whois 查询whois  
- [x] map 查看bgp的peer网络  
- [ ] looking glass查询  

## 使用方法

首先你需要为你的koishi安装koishi-plugin-puppeteer插件，然后再载入此插件

## 可配置参数

```json
{
  dn42: "" //你的dn42 whois服务器地址，默认的地址随时可能无法使用，如果需要稳定性请自行更换
}
```

## 指令列表及用法

请使用help bgp查看  

