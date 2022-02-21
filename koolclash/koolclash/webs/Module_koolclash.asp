<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<meta HTTP-EQUIV="Expires" CONTENT="-1"/>
<link rel="shortcut icon" href="images/favicon.png"/>
<link rel="icon" href="images/favicon.png"/>
<title>软件中心 - KoolClash</title>
<link rel="stylesheet" type="text/css" href="index_style.css" />
<link rel="stylesheet" type="text/css" href="form_style.css" />
<link rel="stylesheet" type="text/css" href="usp_style.css" />
<link rel="stylesheet" type="text/css" href="ParentalControl.css">
<link rel="stylesheet" type="text/css" href="css/icon.css">
<link rel="stylesheet" type="text/css" href="css/element.css">
<link rel="stylesheet" type="text/css" href="res/layer/theme/default/layer.css">
<link rel="stylesheet" type="text/css" href="res/softcenter.css">
<style type="text/css">
    .show-btn {
        border: 1px solid #222;
        background: #576d73;
        font-size:10pt;
        color: #fff;
        padding: 10px 3.75px;
        border-radius: 5px 5px 0px 0px;
        width:15%;
        }
    .active {
        background: #2f3a3e;
    }
    .contentM_qis {
        position: fixed;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        border-radius:10px;
        z-index: 10;
        background-color:#2B373B;
        /*margin-left: -100px;*/
        top: 80px;
        width:755px;
        height:auto;
        box-shadow: 3px 3px 10px #000;
        background: rgba(0,0,0,0.85);
        display:none;
    }
    .user_title{
        text-align:center;
        font-size:18px;
        color:#99FF00;
        padding:10px;
        font-weight:bold;
    }
    .koolclash_btn {
        border: 1px solid #222;
        background: linear-gradient(to bottom, #003333  0%, #000000 100%); /* W3C */
        font-size:10pt;
        color: #fff;
        padding: 5px 5px;
        border-radius: 5px 5px 5px 5px;
        width:16%;
    }
    .koolclash_btn:hover {
        border: 1px solid #222;
        background: linear-gradient(to bottom, #27c9c9  0%, #279fd9 100%); /* W3C */
        font-size:10pt;
        color: #fff;
        padding: 5px 5px;
        border-radius: 5px 5px 5px 5px;
        width:16%;
    }
    input[type=button]:focus {
        outline: none;
    }
</style>
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script type="text/javascript" src="/validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/calendar/jquery-ui.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/switcherplugin/jquery.iphone-switch.js"></script>
<script type="text/javascript" src="/res/softcenter.js"></script>
</head>
<body onload="KoolClash.load();">
<div id="TopBanner"></div>
<div id="Loading" class="popup_bg"></div>
<iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>
<form method="POST" name="form" action="/applydb.cgi?p=koolclash" target="hidden_frame">
<input type="hidden" name="current_page" value="Module_koolclash.asp"/>
<input type="hidden" name="next_page" value="Module_koolclash.asp"/>
<input type="hidden" name="group_id" value=""/>
<input type="hidden" name="modified" value="0"/>
<input type="hidden" name="action_mode" value=""/>
<input type="hidden" name="action_script" value=""/>
<input type="hidden" name="action_wait" value="5"/>
<input type="hidden" name="first_time" value=""/>
<input type="hidden" name="preferred_lang" id="preferred_lang" value="<% nvram_get("preferred_lang"); %>"/>
<input type="hidden" name="SystemCmd" onkeydown="onSubmitCtrl(this, ' Refresh ')" value="config-koolclash.sh"/>
<input type="hidden" name="firmver" value="<% nvram_get("firmver"); %>"/>
<table class="content" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td width="17">&nbsp;</td>
        <td valign="top" width="202">
            <div id="mainMenu"></div>
            <div id="subMenu"></div>
        </td>
        <td valign="top">
            <div id="tabMenu" class="submenuBlock"></div>
            <table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="left" valign="top">
                        <table width="760px" border="0" cellpadding="5" cellspacing="0" bordercolor="#6b8fa3" class="FormTitle" id="FormTitle">
                            <tr>
                                <td bgcolor="#4D595D" colspan="3" valign="top">
                                    <div>&nbsp;</div>
                                    <div style="float:left;" class="formfonttitle">KoolClash - Clash for Koolshare Merlin</div>
                                    <div style="float:right; width:15px; height:25px;margin-top:10px"><img id="return_btn" onclick="KoolClash.backToSoftCenter();" align="right" style="cursor:pointer;position:absolute;margin-left:-30px;margin-top:-25px;" title="返回软件中心" src="/images/backprev.png" onMouseOver="this.src='/images/backprevclick.png'" onMouseOut="this.src='/images/backprev.png'"></img></div>
                                    <div style="margin:30px 0 10px 5px;" class="splitLine"></div>
                                    <div class="formfontdesc">
                                        <p style="margin-top: 4px">Clash 是一个基于规则的代理程序，兼容 Shadowsocks、Vmess 等协议，拥有像 Surge 一样强大的代理规则。</p>
                                        <p>KoolClash 是 Clash 在 Koolshare Merlin 上的客户端。</p>
                                        <p style="margin-top: 12px">
                                            <a href="https://github.com/Dreamacro/clash" target="_blank">Clash on GitHub</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                            <a href="https://github.com/mikefarah/yq" target="_blank">yq is a command-line YAML processor on GitHub</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                            <a href="https://koolclash.js.org" target="_blank">KoolClash 使用文档</a>
                                        </p>
									</div>
                                    <table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable">
                                        <tr>
                                            <th>
                                                <label><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(0)">开启Clash</a></label>
                                            </th>
                                            <td colspan="2">
                                                <div class="switch_field" style="display:table-cell;float: left;">
                                                    <label for="koolclash_enable">
                                                        <input id="koolclash_enable" class="switch" type="checkbox" style="display: none;">
                                                        <div class="switch_container" >
                                                            <div class="switch_bar"></div>
                                                            <div class="switch_circle transition_style">
                                                                <div></div>
                                                            </div>
                                                        </div>
                                                    </label>
                                                </div>
                                                <div id="koolclash-version-msg" style="padding-top:5px;margin-left:20px;margin-top:0px;float: left;"></div>
                                                <div style="padding-top:5px;margin-right:10px;margin-top:0px;float: right;">
                                                    <a type="button" class="koolclash_btn" style="cursor:pointer" href="https://github.com/SukkaW/Koolshare-Clash/releases" target="_blank">更新日志</a>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th width="20%">Clash 进程状态</th>
                                            <td>
                                                <span id="koolclash_status" name="koolclash_status" color="#1bbf35">正在获取 Clash 进程状态...</span>
                                                <br/>
                                                <span id="koolclash_watchdog_status" name="koolclash_watchdog_status" color="#1bbf35">正在获取 Clash 看门狗进程状态...</span>
                                                <div style="position:relative;margin-right:10px;margin-top:-10px;float:right;">
                                                    <a id="btn-open-clash-dashboard" type="button" class="koolclash_btn" style="cursor:pointer" href="#" target="_blank">Clash 控制面板</a>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th width="20%">连通性检查</th>
                                            <td>
                                                <span id="foreign_http_status">国外连接 - Waiting...</span>
                                                <br/>
                                                <span id="china_http_status">国内连接 - Waiting...</span>
                                            </td>
                                        </tr>
                                    </table>
                                    <table style="margin:10px 0px 0px 0px;border-collapse:collapse" width="100%" height="37px">
                                        <tr width="235px">
                                         <td colspan="4" cellpadding="0" cellspacing="0" style="padding:0" border="1" bordercolor="#000">
                                           <input id="show_btn1" class="show-btn active" style="cursor:pointer" type="button" value="Clash 配置"/>
                                           <input id="show_btn2" class="show-btn" style="cursor:pointer" type="button" value="附加设置"/>
                                           <input id="show_btn3" class="show-btn" style="cursor:pointer" type="button" value="调试工具"/>
                                         </td>
                                         </tr>
                                    </table>
                                    <div id="koolclash_table_1">
                                        <table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" class="FormTable_table" style="box-shadow: 3px 3px 10px #000;margin-top: 0px;">
                                            <thead>
                                                <tr>
                                                    <td colspan="2">KoolClash 配置文件</td>
                                                </tr>
                                            </thead>
                                            <tr>
                                                <th width="20%">Clash 配置上传</th>
                                                <td style="text-align: left;">
                                                    <input type="file" id="koolclash-file-config" class="input_32_table"/>
                                                    <a id="koolclash-btn-upload" type="button" class="koolclash_btn" style="cursor:pointer" href="javascript:void(0);" onclick="KoolClash.submitClashConfig();">上传配置文件</a>
                                                    <a type="button" class="koolclash_btn" style="cursor:pointer" href="javascript:void(0);" onclick="open_conf('frps_settings');" >查看当前配置</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th width="20%">Clash 托管配置</th>
                                                <td style="text-align: left;">
                                                    <input id="koolclash_config_suburl" type="text" class="input_32_table" value="" placeholder="https://api.example.com/clash"/>
                                                    <a id="koolclash-btn-del-suburl" type="button" class="koolclash_btn" style="cursor:pointer" href="javascript:void(0);" onclick="KoolClash.deleteSuburl();">清空托管 URL</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th width="20%">自定义 DNS 配置</th>
                                                <td style="text-align: left;">
                                                    <textarea id="koolclash_config_dns" class="textarea_log_table" style="height:150px;">正在加载存储的 Clash DNS Config 配置...</textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th width="20%">IP/CIDR 白名单</th>
                                                <td style="text-align: left;">
                                                    <textarea id="koolclash_firewall_white_ipset" class="textarea_log_table" style="height:150px;"></textarea>
                                                    <p style="margin-top: 8px">不通过 Clash 的 IP/CIDR 外网地址，一行一个，例如：</p>
                                                    <p>119.29.29.29</p>
                                                    <p>210.2.4.0/24</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th width="20%">MAC 地址黑名单</th>
                                                <td style="text-align: left;">
                                                    <textarea id="koolclash_firewall_black_macset" class="textarea_log_table" style="height:150px;"></textarea>
                                                    <p style="margin-top: 8px">需通过 Clash 的 MAC 地址，一行一个，例如：</p>
                                                    <p>04:CF:8C:E9:54:A9</p>
                                                    <p>7C:49:EB:C1:8F:B5</p>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="koolclash_table_2" style="display:none;">
                                        <table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" class="FormTable_table" style="box-shadow: 3px 3px 10px #000;margin-top: 0px;">
                                            <thead>
                                                <tr>
                                                    <td colspan="2">Clash 外部控制</td>
                                                </tr>
                                            </thead>
                                            <tr>
                                                <th width="20%">Host</th>
                                                <td>
                                                    <input type="text" id="koolclash_dashboard_host" class="input_3_table" style="width:98%;" value=""/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th width="20%">端口</th>
                                                <td>
                                                    <input type="text" class="input_3_table" style="width:98%;" value="6170" readonly/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th width="20%">密钥</th>
                                                <td>
                                                    <input type="text" id="koolclash_dashboard_secret" class="input_3_table" style="width:98%;" value=""/>
                                                </td>
                                            </tr>
                                            <thead>
                                                <tr>
                                                    <td colspan="2">GeoIP 数据库</td>
                                                </tr>
                                            </thead>
                                            <tr>
                                                <th width="20%">GeoIP LicenseKey</th>
                                                <td>
                                                    <input id="koolclash_geoip_licensekey" type="text" class="input_32_table" style="width:98%;" value=""/>
                                                    <div style="margin-left:4px;margin-top:10px;float:left;text-align:left;">
                                                        <p>请至 <a href="https://blog.maxmind.com/2019/12/18/significant-changes-to-accessing-and-using-geolite2-databases/" target="_blank">MaxMind提供的原因解答页面</a> 了解获取LicenseKey的原因及方法</p>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th width="20%">GeoIP 数据库版本</th>
                                                <td>
                                                    <div style="margin-left:4px;margin-top:10px;float:left;text-align:left;">
                                                        <i>当前 IP 数据库版本</i><i id="koolclash_ipdb_version"></i>
                                                        <a id="koolclash-btn-update-ipdb" class="koolclash_btn" style="cursor:pointer;margin-left: 16px; margin-top: -6px;" href="javascript:void(0);" onclick="KoolClash.updateIPDB();">更新 IP 数据库</a>
                                                        <p>Clash 使用由 <a href="https://www.maxmind.com/" target="_blank">MaxMind</a> 提供的 GeoLite2 IP 数据库解析 GeoIP 规则</p>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="koolclash_table_3" style="display:none;">
                                        <table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" class="FormTable_table" style="box-shadow: 3px 3px 10px #000;margin-top: 0px;">
                                            <thead>
                                                <tr>
                                                    <td colspan="2">KoolClash 调试工具</td>
                                                </tr>
                                            </thead>
                                            <tr>
                                                <th style="width:20%;">
                                                    <a id="koolclash-btn-debug" class="koolclash_btn" style="cursor:pointer" href="javascript:void(0);" onclick="KoolClash.getDebugInfo();">获取调试信息</a>
                                                </th>
                                                <td>
                                                    <div style="margin:10px 0 8px 0;text-align:center;">
                                                        <p>KoolClash 的调试工具，可以输出 KoolClash 的相关信息、参数。在反馈 KoolClash 的使用问题时附上相关信息可以帮助开发者更好的定位问题。</p>
                                                    </div>
                                                    <textarea id="koolclash_debug_info" class="textarea_log_table" style="height:490px;" readonly wrap="off" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
                                                </td>
                                            </tr>        
                                        </table>
                                    </div>
                                    <div class="apply_gen">
                                        <input type="button" class="button_gen" onclick="KoolClash.save();" value="提交"/>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <div id="koolclash_log_shower"  class="contentM_qis" style="box-shadow: 3px 3px 10px #000;">
                            <div class="user_title">操作日志</div>			
                            <div id="user_tr" style="margin: 10px 10px 10px 10px;width:98%;text-align:center;">
                                <textarea id="koolclash_log" class="textarea_log_table" style="height:510px;" readonly wrap="off" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
                            </div>
                            <div style="margin-top:5px;padding-bottom:10px;width:100%;text-align:center;">
                                <a class="koolclash_btn" style="cursor:pointer" href="javascript:void(0);" onclick="$('#koolclash_log_shower').fadeOut(200);">返回主界面</a>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!--===================================Ending of Main Content===========================================-->
<td width="10" align="center" valign="top"></td>
</form>
<div id="footer"></div>
<script>
var KoolClash = {
    // 创建 KoolClash 界面
    renderUI: () => {
        E('koolclash_enable').checked = window.dbus.koolclash_enable == 1 ? true : false;
        E('koolclash_config_suburl').value=window.dbus.koolclash_suburl || '';
        E('koolclash_firewall_white_ipset').value=Base64.decode(window.dbus.koolclash_firewall_whiteip_base64 || '');
        E('koolclash_firewall_black_macset').value=Base64.decode(window.dbus.koolclash_firewall_blackmac_base64 || '');
        E('koolclash_geoip_licensekey').value=window.dbus.koolclash_ipdb_licensekey || '';   
        E('koolclash_ipdb_version').innerHTML=window.dbus.koolclash_ipdb_version || '没有获取到版本信息';
        E('koolclash_dashboard_host').value = window.dbus.koolclash_api_host || '请先上传 Clash 配置文件';
        E('koolclash_dashboard_secret').value = window.dbus.koolclash_api_secret || 'Clash 配置文件中的 secret';
        E('btn-open-clash-dashboard').href = 'http://'+(window.dbus.koolclash_api_host=='0.0.0.0'?window.location.hostname:window.dbus.koolclash_api_host)+':6170/ui/'
        let configureDns=Base64.decode(window.dbus.koolclash_configure_dns || '');
        if(configureDns!=''){
            E('koolclash_config_dns').innerHTML = configureDns;
        }else if(window.dbus.koolclash_config_yaml_ready==1){
            E('koolclash_config_dns').innerHTML = KoolClash.defaultDNSConfig;
        }else{
            E('koolclash_config_dns').innerHTML = '请先上传 Clash 配置文件';
        }
        $(".show-btn").click(function() {
            $('.show-btn').removeClass('active');
            $(this).addClass('active');
        	E("koolclash_table_1").style.display = "none";
        	E("koolclash_table_2").style.display = "none";
            E("koolclash_table_3").style.display = "none";
            E("koolclash_table_"+$(this).attr("id").replace(/show_btn/g,'')).style.display = "";
        });
    },
    defaultDNSConfig: `# 没有找到保存的 Clash 自定义 DNS 配置，推荐使用以下的配置
dns:
  enable: true
  ipv6: false
  listen: 0.0.0.0:53
  enhanced-mode: redir-host
  nameserver:
    - 119.28.28.28
    - 119.29.29.29
    - 223.5.5.5
    - tls://dns.rubyfish.cn:853
  fallback:
    - tls://1.0.0.1:853
    - tls://8.8.4.4:853
`,
    getHttpAndProcessStatus: () => {
    	let id = parseInt(Math.random() * 100000000),
            postData = JSON.stringify({
                id,
                "method": "koolclash_control.sh",
                "params": ['getHttpAndProcessStatus'],
                "fields": ""
            });
    	$.ajax({
    		type: "POST",
            cache: false,
    		url: "/_api/",
    		async: true,
    		data: postData,
    		success: function(response) {
    			let arr = response.result.split("@@");
    			if (arr[0] == "" || arr[1] == "") {
    				E("foreign_http_status").innerHTML = "国外连接 - " + "Waiting...";
    				E("china_http_status").innerHTML = "国内连接 - " + "Waiting...";
    			} else {
    				E("foreign_http_status").innerHTML = arr[0];
    				E("china_http_status").innerHTML = arr[1];
    			}
                if (arr[2] == "" || arr[3] == "") {
    				E('koolclash_status').innerHTML = `<span style="color: red">获取 Clash 进程运行状态失败！请刷新页面重试`;
                    E('koolclash_watchdog_status').innerHTML = `<span style="color: red">获取 Clash 看门狗进程运行状态失败！请刷新页面重试`;
    			} else {
    				E('koolclash_status').innerHTML = arr[2];
    				E('koolclash_watchdog_status').innerHTML = arr[3];
    			}
    		}
    	});
    	//1: 2-3s, 2:4-7s, 3:8-15s, 4:16-31s, 5:32-63s
    	var time_plus = Math.pow("2", "2") * 1000;
    	var time_base = time_plus - 1000;
    	refreshRate = Math.floor(Math.random() * time_base) + time_plus ;
        setTimeout(() => {
            KoolClash.getHttpAndProcessStatus();
        }, refreshRate);
    },
    checkUpdate: () => {
        let installed = window.dbus.koolclash_version,
            remote = '';
        E('koolclash-version-msg').innerHTML = `当前安装版本&nbsp;:&nbsp;${installed}`;
        // 获取远端版本号
        $.ajax({
            type: "GET",
            cache: false,
            url: "https://koolclash.js.org/koolclash_version",
            success: (resp) => {
                remote = resp;
                E('koolclash-version-msg').innerHTML = `最新发布版本&nbsp;:&nbsp;${remote}，已安装最新版本`;
                if (installed !== remote) {
                    E('koolclash-version-msg').innerHTML = `最新发布版本&nbsp;:&nbsp;${remote}，请及时更新`;
                }
            }
        });
    },
    submitClashConfig: () => {
        let formData = new FormData();
        formData.append('clash.config.yaml', $('#koolclash-file-config')[0].files[0]);
        $.ajax({
            url: '/_upload',
            type: 'POST',
            async: true,
            cache: false,
            data: formData,
            processData: false,
            contentType: false,
            success: (resp) => {
                (() => {
                    let id = parseInt(Math.random() * 100000000),
                        postData = JSON.stringify({
                            id,
                            "method": "koolclash_control.sh",
                            "params": ['uploadClashConfig'],
                            "fields": ""
                        });
                    setTimeout(() => {
                        KoolClash.getLog();
                    }, 100);
                    $.ajax({
                        type: "POST",
                        cache: false,
                        url: "/_api/",
                        data: postData,
                        dataType: "json",
                        success: (resp) => {
                            setTimeout(() => {
                                $('#koolclash_log_shower .koolclash_btn').click();
                                KoolClash.save();
                            }, 1000)
                        },
                        error: () => {
                            console.log("上传配置文件失败");
                        }
                    });
                })();
            },
            error: () => {
                console.log("上传配置文件失败");
            }
        });
    },
    deleteSuburl: () => {
        E('koolclash_config_suburl').value = '';
    },
    updateIPDB: () => {
        let id = parseInt(Math.random() * 100000000),
            postData = JSON.stringify({
                "id": id,
                "method": "koolclash_control.sh",
                "params": ['updateGeoIP', E('koolclash_geoip_licensekey').value],
                "fields": ""
            });
        setTimeout(() => {
            KoolClash.getLog();
        }, 100);
        $.ajax({
            type: "POST",
            cache: false,
            url: "/_api/",
            data: postData,
            dataType: "json",
            error: () => {
                console.log("IP 数据库文件更新失败");
            }
        });
        
    },
    getLog: () => {
        if (typeof _responseLen === undefined) {
            let _responseLen = 0;
        } else {
            _responseLen = 0;
        }
        let noChange = 0;
        $("#koolclash_log_shower").fadeIn(200);
        $.ajax({
            url: '/_temp/koolclash_log.txt',
            type: 'GET',
            cache: false,
            dataType: 'text',
            success: (response) => {
                var retArea = E("koolclash_log");
                if (response.search("XU6J03M6") !== -1) {
                    retArea.value = response.replace("XU6J03M6", " ");
                    retArea.scrollTop = retArea.scrollHeight;
                    $('#koolclash_log_shower .koolclash_btn').append('<span id="koolclash-wait-time"></span>');
                    let seconds=10;
                    var timer = setInterval(() => {
                        seconds--;
                        E('koolclash-wait-time').innerHTML = `（${seconds}）`;
                    }, 1000);
                    setTimeout(() => {
                        clearInterval(timer);
                        $('#koolclash_log_shower #koolclash-wait-time').remove();
                        $('#koolclash_log_shower .koolclash_btn').click();
                    }, seconds*1000);
                    return true;
                }
                if (_responseLen === response.length) {
                    noChange++;
                } else {
                    noChange = 0;
                }
                if (noChange > 8000) {
                    return false;
                } else {
                    setTimeout(() => {
                        KoolClash.getLog();
                    }, 100);
                }
                retArea.value = response.replace("XU6J03M6", " ");
                retArea.scrollTop = retArea.scrollHeight;
                _responseLen = response.length;
            },
            error: () => {
                E("koolclash_log").value = "获取日志失败！";
                return false;
            }
        });
    },
    getDebugInfo: () => {
        let id = parseInt(Math.random() * 100000000),
            postData = JSON.stringify({
                id,
                "method": "koolclash_control.sh",
                "params": ['getDebugInfo'],
                "fields": ""
            });
        fetch(`/_api/`, {
            body: postData,
            method: 'POST',
            cache: 'no-cache',
        }).then((resp) => Promise.all([resp.ok, resp.status, resp.json(), resp.headers]))
            .then(([ok, status, data, headers]) => {
                if (ok) {
                    return JSON.parse(data.result);
                } else {
                    throw new Error(JSON.stringify(json.error));
                }
            })
            .then((data) => {
                let getBrowser = () => {
                    let ua = navigator.userAgent,
                        tem,
                        M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
                    if (ua.match("MicroMessenger"))
                        return "Weixin";
                    if (/trident/i.test(M[1])) {
                        tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
                        return 'IE ' + (tem[1] || '');
                    }
                    if (M[1] === 'Chrome') {
                        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                    }
                    M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
                    if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
                    return M.join(' ');
                };
                E('koolclash_debug_info').value = `
======================== KoolClash 调试工具 ========================
调试信息生成于 ${new Date().toString()}
当前浏览器：${getBrowser()}
-------------------- Koolshare OpenWrt 基本信息 --------------------
固件版本：${data.koolshare_version}
路由器 LAN IP：${data.lan_ip}
------------------------ KoolClash 基本信息 ------------------------
KoolClash 版本：${window.dbus.koolclash_version}
Clash 核心版本：${data.clash_version}
KoolClash 当前状态：${(window.dbus.koolclash_enable === '1') ? `Clash 进程正在运行` : `Clash 进程未在运行`}
用户指定 Clash 外部控制 Host：${(window.dbus.koolclash_api_host) ? window.dbus.koolclash_api_host : `未改动`}
-------------------------- Clash 进程信息 --------------------------
${Base64.decode(data.clash_process)}
------------------------ Clash 配置文件目录 ------------------------
${Base64.decode(data.clash_config_dir)}
------------------------ Clash 配置文件信息 ------------------------
Clash 透明代理端口：${data.clash_redir}
Clash 是否允许局域网连接：${data.clash_allow_lan}
Clash 外部控制监听地址：${data.clash_ext_controller}
--------------------- Clash 配置文件 DNS 配置 ----------------------
Clash DNS 是否启用：${data.clash_dns_enable}
Clash DNS 解析 IPv6：${(data.clash_dns_ipv6 === 'null') ? `false` : data.clash_dns_ipv6}
Clash DNS 增强模式：${data.clash_dns_mode}
Clash DNS 监听：${data.clash_dns_listen}
-------------------- KoolClash 自定义 DNS 配置 ---------------------
${Base64.decode(data.fallbackdns)}
------------------------- iptables 条目 ---------------------------
 * iptables mangle 中 Clash 相关条目
${Base64.decode(Base64.decode(data.iptables_mangle))}

 * iptables nat 中 Clash 相关条目
${Base64.decode(Base64.decode(data.iptables_nat))}

 * iptables mangle 中 koolclash 链
${Base64.decode(Base64.decode(data.iptables_mangle_clash))}

 * iptables nat 中 koolclash 链
${Base64.decode(Base64.decode(data.iptables_nat_clash))}

* iptables mangle 中 koolclash_dns 链
${Base64.decode(Base64.decode(data.iptables_mangle_clash_dns))}

 * iptables nat 中 koolclash_dns 链
${Base64.decode(Base64.decode(data.iptables_nat_clash_dns))}

 * iptables nat 中 53 端口相关条目
${Base64.decode(data.chromecast_nu)}
---------------------- ipset 白名单 IP 列表 ------------------------
${Base64.decode(data.firewall_white_ip)}
===================================================================
`;
            })
    },
    save: () => {
        window.dbus.koolclash_enable = E('koolclash_enable').checked?'1':'0';
        window.dbus.koolclash_suburl = E('koolclash_config_suburl').value || '';
        window.dbus.koolclash_configure_dns = Base64.encode(E('koolclash_config_dns').value.replace('# 没有找到保存的 Clash 自定义 DNS 配置，推荐使用以下的配置\n', '').replace('请先上传 Clash 配置文件', '')) || '';
        window.dbus.koolclash_firewall_whiteip_base64 = Base64.encode(E('koolclash_firewall_white_ipset').value) || '';
        window.dbus.koolclash_firewall_blackmac_base64 = Base64.encode(E('koolclash_firewall_black_macset').value) || '';
        window.dbus.koolclash_ipdb_licensekey = E('koolclash_geoip_licensekey').value || '';
        window.dbus.koolclash_ipdb_version = E('koolclash_ipdb_version').innerHTML || '';
        window.dbus.koolclash_api_host = E('koolclash_dashboard_host').value.replace('请先上传 Clash 配置文件','') || '';
        window.dbus.koolclash_api_secret = E('koolclash_dashboard_secret').value.replace('Clash 配置文件中的 secret','') || '';

        //showLoading();
        let id = parseInt(Math.random() * 100000000),
            postData = JSON.stringify({
                id,
                "method": "koolclash_control.sh",
                "params": [E('koolclash_enable').checked?'start':'stop'],
                "fields": window.dbus
            });
        setTimeout(() => {
            KoolClash.getLog();
        }, 100);
        $.ajax({
            type: "POST",
            cache: false,
            async: true,
            url: "/_api/",
            data: postData,
            dataType: "json",
            success: (resp) => {
                if (resp.result === 'nofile') {
                    console.log('关键文件缺失，Clash 无法启动！');
                } else if (resp.result === 'nodns') {
                    console.log('在 Clash 配置文件中没有找到正确的 DNS 设置！');
                } else {
                    console.log('Clash 成功启动！');
                }
                var submitTimer = setInterval(() => {
                    if( $("#koolclash_log_shower").css("display")=='none' ) {
                        clearInterval(submitTimer);
                        refreshpage();
                    }
                }, 500);
            },
            error: () => {
                console.log('Clash (可能)启动失败！请手工检查 Clash 运行状态！');
            }
        });
    },
    load: (cb) => {
        window.dbus = {}
        show_menu(menu_hook); //插件主题
        fetch(`/_api/koolclash`, { method: 'GET' })
            .then((resp) => Promise.all([resp.ok, resp.status, resp.json(), resp.headers]))
            .then(([ok, status, data, headers]) => {
                if (ok) {
                    window.dbus = data.result[0];
                } else {
                    throw new Error(JSON.stringify(json.error));
                }
            })
            .then((res) => {
                KoolClash.renderUI();
            })
            .then((res) => {
                KoolClash.getHttpAndProcessStatus();
                KoolClash.checkUpdate();
            })
    },
    backToSoftCenter: () => {
        location.href = "/Module_Softcenter.asp";
    },
}
//插件主题
function menu_hook(title, tab) {
	tabtitle[tabtitle.length - 1] = new Array("", "KoolClash");
	tablink[tablink.length - 1] = new Array("", "Module_koolclash.asp");
}
</script>
</body>
</html>