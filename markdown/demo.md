# 智慧网关restful接口文档 #
	说明：restful_server端口号为20030
	url前缀格式：http://admin:123@server ip:20030
## 二、NET ##
---
### 2.1 url后缀 ###
```
url后缀： /net
```
### 2.2 WAN口 ###
#### 2.2.1 WAN口参数配置 ####
```
method: POST
```
##### 2.2.1.1 client--->server #####
```
{
	"command": "setWan",
	"param": {
		"type": "static", 	//dhcp->自动分配, static->手动
		"ip": "192.168.22.123",	//if auto,ip mask network do not needed
		"mask": "255.255.255.0",
		"network": "192.168.22.0", //所在网段
		"gateway": "192.168.22.1",
		"dns1": "8.8.8.8",
		"dns2": "114.114.114.114" //1、2都要有
	}
}
```
##### 2.2.1.2 client<---server #####
```
{
	"resultCode": resultcode,
	"result": "config net wan success"
}
```
#### 2.2.2 查询wan口参数 ####
```
method: GET
```
##### 2.2.2.1 client--->server #####
```
{
	"command": "getWan"
}
```
##### 2.2.2.2 client<---server #####
```
{
	"resultCode": resultcode,
	"result": {
		"type": "static", //dhcp->自动分配, static->手动
		"ip": "192.168.22.123",
		"mask": "255.255.255.0",
		"network": "192.168.22.0", //所在网段
		"gateway": "192.168.22.1",
		"dns1": "8.8.8.8",
		"dns2": "114.114.114.114" 
	}
}
```

### 2.3 LAN口 ###
#### 2.3.1 LAN口参数配置 ####
```
method: POST
```
##### 2.3.1.1 client--->server #####
```
{
	"command": "setLan",
	"param":{
		"type": "auto", 			//auto ->自动分配, static->手动
		"ip": "192.168.7.123",		//if auto,ip mask network do not needed
		"mask": "255.255.255.0",
		"network": "192.168.7.0"	//所在网段
	}
}
```
##### 2.3.1.2 client<---server #####
```
{
	"resultCode": resultcode,
	"result": "config net lan success"
}
```
#### 2.3.2 查询lan口参数 ####
```
method: GET
```
##### 2.3.2.1 client--->server #####
```
{
	"command": "getLan"
}
```
##### 2.3.2.2 client<---server #####
```
{
	"resultCode": resultcode,
	"result": {
		"ip": "192.168.7.1",
		"mask": "255.255.255.0",
		"dns": "8.8.8.8"
	}
}
```
#### 2.3.3 lan口的dhcpd参数配置 ####
```
method: POST
```
##### 2.3.3.1 client--->server #####
```
{
	"command": "setDhcpd",
	"param":{
		"start_ip": "192.168.7.10",
		"end_ip": "192.168.7.100",
		"dns1": "..", //dns1必须有
		"dns2": ".." //用户可以不输dns2，不输时就传空
	}
}
```
##### 2.3.3.2 client<---server #####
```
{
	"resultCode": resultcode,
	"result": "config net_lan_dhcpd success"
}
```
#### 2.3.4 查询lan口的dhcpd参数 ####
```
method: GET
```
##### 2.3.4.1 client--->server #####
```
{
	"command": "getDhcpd"
}
```
##### 2.3.4.2 client<---server #####
```
{
	"resultCode": resultcode,
	"result": {
		"addrStart": "192.168.7.10",
		"addrEnd": "192.168.7.100",
		"dns1": "..", //dns1必须有
		"dns2": ".." //用户可以不输dns2，不输时就传空
	}
}
```
### 2.4 apply接口 ###
其让参数真正生效，因为前面的命令只是把参数更新到内存和保存到smartgw.json文件中
```
method: POST
```
##### 2.4.1 client--->server #####
```
{
	"command": "netApply",
	"param":{
		"obj": "wan"/"lan"/"dhcpd"/"all"
	}
}
```
##### 2.4.2 client<---server #####
```
{
	"resultCode": resultcode,
	"result": " net apply success"
}
```

## 三、摄像头 ##
```
当前仅支持网关下一个摄像头的方案，其中：
网关与摄像头通过onvif协议交互
上位机需配置摄像头的用户名、密码
网关自动转码推流，上位机需要配置推流地址
对摄像头处理，配置和控制命令分开
总体方案见xxx方案图
```
---
### 3.1 url后缀 ###
```
url后缀： /camera
```
### 3.2 摄像头参数 ###
#### 3.2.1 摄像头参数配置 ####
```
method: POST
```
##### 3.2.1.1 client--->server #####
```
{
	"command":"config",
	"param":{		
		"username": "admin",
		"password": "fonda123",
		"osd": "FONDA",
		"rtmpUrl": "rtmp://192.168.22.128:1935/live"
	}
} 
```
##### 3.2.1.2 client<---server #####
```
{
	"resultCode": resultcode，
	"result": "config camara success"
}
```

#### 3.2.2 摄像头参数查询 ####
```
method: GET
```
##### 3.2.2.1 client--->server #####
```
{
	"command":"getInfo"
} 
```

##### 3.2.2.2 client<---server #####
```
{
	"resultCode": resultCode,
	"result":{		
		"username": "admin",
		"password": "fonda123",
		"osd": "FONDA",
		"rtmpUrl": "rtmp://192.168.22.128:1935/live"
	}
}
```

### 3.3 摄像头云台控制 ###
```
method: POST
```
#### 3.3.1 client--->server ####
```
{
	"command":"ptzControl",
	"param": 0 //(int) 0->left, 1->right, 2->up, 3->down, 4->stop
}
```
#### 3.3.2 client<---server ####
```
{
	"resultCode": resultCode,
	"result":"result"
}
```

### 3.4 摄像头流控制 ###
```
method: POST
```
#### 3.4.1 client--->server ####
```
{
	"command":"streamControl",
	"param" : {
		"streamType": "main", 		//main stream,  sub stream
		"streamAction": "pause" 	//start, stop ,pause
	}
}
```
#### 3.4.2 client<---server ####
```
{
	"resultCode": resultCode,
	"result":"result"
}
```

### 3.5 摄像头状态查询###
```
method: GET
```
#### 3.5.1 client--->server ####
```
{
	"command":"getStatus"
}
```
#### 3.5.2 client<---server ####
```
{
	"resultCode": resultCode,
	"result":{		
		"connState": "online",  //online  offline Error ...
		"PTZState": 0, 		    //(int) 0->left, 1->right, 2->up, 3->down, 4->stop
		"streamType": "main", 		//main, sub
		"streamState": "start"   	//start stop pause
	}
}
```

## 四、气象站 ##
---
### 4.1 url后缀 ###
```
url后缀: /sensor/env
```
### 4.2 气象站参数设置 ###
```
method： POST
```
#### 4.2.1 client--->server ####
```
{
	"command": "setParam",
	"param": {
		"type": "FRT", 
		"addr": 48
	}
}
```

#### 4.2.2 client<---server ####
```
{
	"resultCode": resultcode，
	"result": "set env_sensor_param success"
}
```
### 4.3 气象站参数读取 ###
```
method: GET
```
#### 4.3.1 client--->server ####
```
{
	"command": "getParam"
}
```
#### 4.3.2 client<---server ####
```
{
	"resultCode": resultcode
	"result": {
		"type": "FRT", 
		"addr": 48
	}
}
```
### 4.4 气象站数据读取 ###
```
method: GET
```
#### 4.4.1 client--->server ####
```
{
	"command": "getData"
}
```
#### 4.4.2 client<---server ####
```
正常回复：
{
	"resultCode":	1000,
	"result":	{
		"status":	"online",
		"data":	{
			"temperature":	" 17.2",
			"windSpeed":	" 0.0",
			"humidity":	" 50.6",
			"rainfall":	"    0.0",
			"noise":	" 55.5",
			"airPressure":	"1025",
			"pm2.5":	"  50",
			"pm10":	"  64",
			"windDirect":	"北风"
		}
	}
}
异常回复：
{
	"resultCode":	4004,
	"result":	{
		"status":	"offline"
	}
}
```
## 五、日志打印参数设置和查询 ##
---
### 5.1 url ###
```
url后缀: /log/settings
```
### 5.2 设置日志打印参数 ###
```
method: POST
```
#### 5.2.1 client--->server ####
```
{
	"command": "setParam",
	"param": {
		"logLevel": "fatal"/"error"/"warn"/"info"/"debug"/"trace",
		"logTarget": "stdout"/"server",
		"logTime": "simple"/"complex"/"uptime"
	}
}
```
#### 5.2.2 client<---server ####
```
{
	"resultCode": 1000,
	"result": "set log_settings param success"
}
```
### 5.3 查询日志打印参数（**预留**） ###
```
method: GET
```
#### 5.3.1 client--->server ####
```
{
	"command": "getParam"
}
```
#### 5.3.2 client<---server ####
```
{
	"resultCode": 1000,
	"result": {
		"logLevel": "fatal"/"error"/"warn"/"info"/"debug"/"trace",
		"logTarget": "stdout"/"server",
		"logTime": "simple"/"complex"/"uptime"
	}
}
```

## 五、设置服务器IP地址和端口##
---
### 6.1 url ###
```
url后缀: /fdserver/settings
```
### 6.2 设置服务器IP地址和端口 ###
```
method: POST
```
#### 6.2.1 client--->server ####
```
{
	"command": "setParam",
	"param": {
		"ip": "183.129.241.36"，
		"port": "20054"
	}
}
```
#### 5.2.2 client<---server ####
```
{
	"resultCode": 1000,
	"result": "set server ip address and port success"
}
```
### 6.3 查询服务器IP地址和端口 ###
```
method: GET
```
#### 6.3.1 client--->server ####
```
{
	"command": "getParam"
}
```
#### 6.3.2 client<---server ####
```
{
	"resultCode": 1000,
	"result": {
		"ip": "183.129.241.36"，
		"port": "20054"
	}
}
```
---
## 返回值定义 ##
```
resultCode-返回状态码
result    -状态码说明 

---
	//所有接口，返回成功，resultCode为1000
 	1000-ok  
	
	//ipc所有错误状态从1001开始
	1001-没有ipc
	1002-用户/密码未配置
	1003-用户/密码错误
	1004- rtmp未配置
	1005- rtmp用户/密码错误
	1006-网络错误
	1007-其它错误
	摄像头相关接口返回错误值从1001开始

	//智慧网关本身状态从2001开始
	2001-a错误  //开发时补全	

	//熙讯屏错误状态从3001开始
   	3001-未检测到控制卡
	3002-

	//气象站错误状态从4001开始
	4001-气象通讯错误

	//日志打印参数设置和查询返回错误状态从5001开始
	5001-命令错误
	5002-参数错误
```
