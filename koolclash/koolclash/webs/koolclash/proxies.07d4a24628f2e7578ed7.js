(window.webpackJsonp=window.webpackJsonp||[]).push([[2],{"/Uh6":function(e,t,n){e.exports={proxyLatency:"_2tHS8vcjWZ"}},"0tMl":function(e,t,n){e.exports={topBar:"_1vpeUMroNJ",topBarRight:"pGNJbFaunZ",textFilterContainer:"_1aJVGJw_DC",group:"_2gOPGelc7s",spining:"_3BayoLOhA0",spining_keyframes:"NKvZlK5zKz"}},"5JRb":function(e,t,n){e.exports={labeledInput:"_1h4Qixiwxj"}},DsEz:function(e,t,n){e.exports={input:"_1LsRPWba72"}},LhcJ:function(e,t,n){"use strict";n.d(t,"a",(function(){return u}));var a=n("ODXe"),r=n("hbEN"),c=n("q1tI"),l=n("dBaT"),o=c.useCallback,i=c.useState,s=c.useMemo;function u(e){var t=Object(l.useRecoilState)(e),n=Object(a.a)(t,2)[1],c=i(""),u=Object(a.a)(c,2),m=u[0],p=u[1],d=s((function(){return Object(r.a)(n,300)}),[n]);return[o((function(e){p(e.target.value),d(e.target.value)}),[d]),m]}},MR5J:function(e,t,n){e.exports={FlexCenter:"W_0q0BiEOR"}},RL2M:function(e,t,n){e.exports={header:"_37wt2_a2Gx",arrow:"L80zPM0Rx0",isOpen:"_36RO7_wtuv",btn:"_2XKN3NArpV",qty:"_1s98xvUoBx"}},UVHL:function(e,t,n){e.exports={select:"t6lsDKNXTK"}},UmKA:function(e,t,n){e.exports={overlay:"_2OKIZuCJtW",cnt:"_1y6NeshM4O",afterOpen:"_25KARE4UsT"}},agpB:function(e,t,n){e.exports={updatedAt:"_2PJqMIeTLt",body:"_2bdge0dkRf",actionFooter:"Vp69gn8Y28",refresh:"_32jty5m2Ss"}},drH3:function(e,t,n){e.exports={list:"_1Zy60rJawW",listSummaryView:"_1YJnElh2Sr"}},kCV3:function(e,t,n){"use strict";n.r(t);n("yXV3"),n("2B1R"),n("pDQq"),n("zKZe");var a=n("ODXe"),r=n("q1tI"),c=n.n(r),l=n("ySHw"),o=n("9Koi"),i=n("OADI"),s=n("vJea"),u=n("GmYy"),m=n("n57c"),p=n("DKqX"),d=n("iuhU"),f=n("9rZX"),v=n.n(f),b=n("Z9Yo"),y=n.n(b),E=n("UmKA"),h=n.n(E),O=r.useMemo;function x(e){var t=e.isOpen,n=e.onRequestClose,a=e.children,c=O((function(){return{base:Object(d.a)(y.a.content,h.a.cnt),afterOpen:h.a.afterOpen,beforeClose:""}}),[]);return r.createElement(v.a,{isOpen:t,onRequestClose:n,className:c,overlayClassName:Object(d.a)(y.a.overlay,h.a.overlay)},a)}var g=n("9cvt"),C=n("WfPo");function j(e){var t=e.color,n=void 0===t?"currentColor":t,a=e.size,c=void 0===a?24:a;return r.createElement("svg",{fill:"none",xmlns:"http://www.w3.org/2000/svg",viewBox:"0 0 24 24",width:c,height:c,stroke:n,strokeWidth:"2",strokeLinecap:"round",strokeLinejoin:"round"},r.createElement("path",{d:"M2 6h9M18.5 6H22"}),r.createElement("circle",{cx:"16",cy:"6",r:"2"}),r.createElement("path",{d:"M22 18h-9M6 18H2"}),r.createElement("circle",{r:"2",transform:"matrix(-1 0 0 1 8 18)"}))}var w=n("MR5J"),k=n.n(w);function N(e){var t=e.children;return r.createElement("div",{className:k.a.FlexCenter},t)}var S=r.useRef,B=r.useEffect;function _(e){var t=e.onClickPrimaryButton,n=e.onClickSecondaryButton,a=S(null),c=S(null);B((function(){a.current.focus()}),[]);return r.createElement("div",{onKeyDown:function(e){39===e.keyCode?c.current.focus():37===e.keyCode&&a.current.focus()}},r.createElement("h2",null,"Close Connections?"),r.createElement("p",null,'Click "Yes" to close those connections that are still using the old selected proxy in this group'),r.createElement("div",{style:{height:30}}),r.createElement(N,null,r.createElement(m.a,{onClick:t,ref:a},"Yes"),r.createElement("div",{style:{width:20}}),r.createElement(m.a,{onClick:n,ref:c},"No")))}var L=n("0tMl"),P=n.n(L),R=n("o0o1"),A=n.n(R),D=(n("ls82"),n("HaE+")),M=n("j7o3"),U=n("RL2M"),K=n.n(U),T=n("riol");function J(e){var t=e.name,n=e.type,a=e.toggle,r=e.isOpen,l=e.qty;return c.a.createElement("div",{className:K.a.header},c.a.createElement("div",{onClick:a,style:{cursor:"pointer"}},c.a.createElement(T.b,{name:t,type:n})),"number"==typeof l?c.a.createElement("span",{className:K.a.qty},l):null,c.a.createElement(m.a,{kind:"minimal",onClick:a,className:K.a.btn},c.a.createElement("span",{className:Object(d.a)(K.a.arrow,{[K.a.isOpen]:r})},c.a.createElement(M.a,{size:20}))))}n("TeQF"),n("ToJy"),n("EnZy"),n("SYor");var q=n("KQm4"),z=n("dBaT"),I=r.useMemo;var Z=function(e,t){if(e&&"number"==typeof e.number&&e.number>0)return e.number;var n=t&&t.type;return n&&u.a.indexOf(n)>-1?-1:999999},F={Natural:function(e){return e},LatencyAsc:function(e,t,n){return e.sort((function(e,a){return Z(t[e],n&&n[e])-Z(t[a],n&&n[a])}))},LatencyDesc:function(e,t,n){return e.sort((function(e,a){var r=Z(t[e],n&&n[e]);return Z(t[a],n&&n[a])-r}))},NameAsc:function(e){return e.sort()},NameDesc:function(e){return e.sort((function(e,t){return e>t?-1:e<t?1:0}))}};function H(e,t,n,r,c){var l=Object(z.useRecoilState)(u.k),o=Object(a.a)(l,1)[0];return I((function(){return function(e,t,n,a,r,c){var l=Object(q.a)(e);return n&&(l=function(e,t){return e.filter((function(e){var n=t[e];return void 0===n||0!==n.number}))}(e,t)),"string"==typeof a&&""!==a&&(l=function(e,t){var n=t.toLowerCase().split(" ").map((function(e){return e.trim()})).filter((function(e){return!!e}));return 0===n.length?e:e.filter((function(e){for(var t=0;t<n.length;t++){var a=n[t];if(e.toLowerCase().indexOf(a)>-1)return!0}return!1}))}(l,a)),F[r](l,t,c)}(e,t,n,o,r,c)}),[e,t,n,o,r,c])}var V=n("xKoM"),G=n.n(V),W=n("wztZ"),Y=n.n(W),X=n("/Uh6"),Q=n.n(X);function $(e){var t=e.number,n=e.color;return r.createElement("span",{className:Q.a.proxyLatency,style:{color:n}},r.createElement("span",null,t," ms"))}var ee=r.useMemo,te="#67c23a",ne="#d4b75c",ae="#e67f3c",re="#909399";function ce(){var e=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{},t=e.number;return 0===t?re:t<200?te:t<400?ne:"number"==typeof t?ae:re}var le=function(e,t){var n=t.name,a=Object(u.e)(e),r=Object(u.d)(e);return{proxy:a[n],latency:r[n]}},oe=Object(C.a)(le)((function(e){var t=e.now,n=e.name,a=e.proxy,c=e.latency,l=e.isSelectable,o=e.onClick,i=ee((function(){return ce(c)}),[c]);return r.createElement("div",{className:Object(d.a)(Y.a.proxy,{[Y.a.now]:t,[Y.a.error]:c&&c.error,[Y.a.selectable]:l}),onClick:function(){l&&o&&o(n)}},r.createElement("div",{className:Y.a.proxyName},n),r.createElement("div",{className:Y.a.row},r.createElement("span",{className:Y.a.proxyType,style:{opacity:t?.6:.2}},a.type),c&&c.number?r.createElement($,{number:c.number,color:i}):null))})),ie=Object(C.a)(le)((function(e){var t=e.now,n=e.name,a=e.proxy,c=e.latency,l=e.isSelectable,o=e.onClick,i=ee((function(){return function(e,t){return u.a.indexOf(t)>-1?"linear-gradient(135deg, white 15%, #999 15% 30%, white 30% 45%, #999 45% 60%, white 60% 75%, #999 75% 90%, white 90% 100%)":ce(e)}(c,a.type)}),[c,a]),s=ee((function(){var e=n;return c&&"number"==typeof c.number&&(e+=" "+c.number+" ms"),e}),[n,c]);return r.createElement("div",{title:s,className:Object(d.a)(Y.a.proxySmall,{[Y.a.now]:t,[Y.a.selectable]:l}),style:{background:i},onClick:function(){l&&o&&o(n)}})})),se=n("drH3"),ue=n.n(se);function me(e){var t=e.all,n=e.now,a=e.isSelectable,c=e.itemOnTapCallback,l=t;return r.createElement("div",{className:ue.a.list},l.map((function(e){return r.createElement(oe,{key:e,onClick:c,isSelectable:a,name:e,now:e===n})})))}function pe(e){var t=e.all,n=e.now,a=e.isSelectable,c=e.itemOnTapCallback;return r.createElement("div",{className:ue.a.listSummaryView},t.map((function(e){return r.createElement(ie,{key:e,onClick:c,isSelectable:a,name:e,now:e===n})})))}var de=r.createElement,fe=r.useCallback,ve=r.useMemo,be=r.useState;function ye(){return r.createElement("div",{className:G.a.zapWrapper},r.createElement(l.a,{size:16}))}var Ee=Object(C.a)((function(e,t){var n=t.name,a=t.delay,r=Object(u.e)(e),c=Object(i.d)(e),l=Object(i.g)(e),o=Object(i.e)(e),s=r[n];return{all:s.all,delay:a,hideUnavailableProxies:o,proxySortBy:l,proxies:r,type:s.type,now:s.now,isOpen:c["proxyGroup:"+n]}}))((function(e){var t=e.name,n=e.all,c=e.delay,l=e.hideUnavailableProxies,o=e.proxySortBy,i=e.proxies,s=e.type,p=e.now,d=e.isOpen,f=e.apiConfig,v=e.dispatch,b=H(n,c,l,o,i),y=ve((function(){return"Selector"===s}),[s]),E=Object(C.c)(),h=E.app.updateCollapsibleIsOpen,O=E.proxies.requestDelayForProxies,x=fe((function(){h("proxyGroup",t,!d)}),[d,h,t]),g=fe((function(e){y&&v(Object(u.m)(f,t,e))}),[f,v,t,y]),j=be(!1),w=Object(a.a)(j,2),k=w[0],N=w[1],S=fe(Object(D.a)(A.a.mark((function e(){return A.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:return N(!0),e.prev=1,e.next=4,O(f,b);case 4:e.next=8;break;case 6:e.prev=6,e.t0=e.catch(1);case 8:N(!1);case 9:case"end":return e.stop()}}),e,null,[[1,6]])}))),[b,f,O]);return r.createElement("div",{className:G.a.group},r.createElement("div",{style:{display:"flex",alignItems:"center"}},r.createElement(J,{name:t,type:s,toggle:x,qty:b.length,isOpen:d}),r.createElement(m.a,{kind:"minimal",onClick:S,isLoading:k},r.createElement(ye,null))),de(d?me:pe,{all:b,now:p,isSelectable:y,itemOnTapCallback:g}))})),he=n("FVam"),Oe=n("ZMKu"),xe=n("OAQO"),ge=n("bdgK"),Ce=c.a.memo,je=c.a.useState,we=c.a.useRef,ke=c.a.useEffect;var Ne={initialOpen:{height:"auto",transition:{duration:0}},open:function(e){return{height:e,opacity:1,visibility:"visible",transition:{duration:.3}}},closed:{height:0,opacity:0,visibility:"hidden",transition:{duration:.3}}},Se={open:{x:0},closed:{x:20}},Be=Ce((function(e){var t,n,r=e.children,l=e.isOpen,o=(t=l,n=we(),ke((function(){n.current=t}),[t]),n.current),i=function(){var e=we(),t=je({height:0}),n=Object(a.a)(t,2),r=n[0],c=n[1];return ke((function(){var t=new ge.a((function(e){var t=Object(a.a)(e,1)[0];return c(t.contentRect)}));return e.current&&t.observe(e.current),function(){return t.disconnect()}}),[]),[e,r]}(),s=Object(a.a)(i,2),u=s[0],m=s[1].height;return c.a.createElement("div",null,c.a.createElement(Oe.a.div,{animate:l&&o===l?"initialOpen":l?"open":"closed",custom:m,variants:Ne},c.a.createElement(Oe.a.div,{variants:Se,ref:u},r)))})),_e=n("agpB"),Le=n.n(_e),Pe=r.useState,Re=r.useCallback;var Ae={rest:{scale:1},pressed:{scale:.95}},De={rest:{rotate:0},hover:{rotate:360,transition:{duration:.3}}};function Me(){return r.createElement(Oe.a.div,{className:Le.a.refresh,variants:Ae,initial:"rest",whileHover:"hover",whileTap:"pressed"},r.createElement(Oe.a.div,{className:"flexCenter",variants:De},r.createElement(xe.a,{size:16})))}var Ue=Object(C.a)((function(e,t){var n=t.proxies,a=t.name,r=Object(i.e)(e),c=Object(u.d)(e),l=Object(i.d)(e);return{apiConfig:Object(i.c)(e),proxies:n,delay:c,hideUnavailableProxies:r,proxySortBy:Object(i.g)(e),isOpen:l["proxyProvider:"+a]}}))((function(e){var t=e.name,n=e.proxies,c=e.delay,o=e.hideUnavailableProxies,i=e.proxySortBy,s=e.vehicleType,p=e.updatedAt,d=e.isOpen,f=e.dispatch,v=e.apiConfig,b=H(n,c,o,i),y=Pe(!1),E=Object(a.a)(y,2),h=E[0],O=E[1],x=Re((function(){return f(Object(u.n)(v,t))}),[v,f,t]),g=Re(Object(D.a)(A.a.mark((function e(){return A.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:return O(!0),e.next=3,f(Object(u.i)(v,t));case 3:O(!1);case 4:case"end":return e.stop()}}),e)}))),[v,f,t,O]),j=Object(C.c)().app.updateCollapsibleIsOpen,w=Re((function(){j("proxyProvider",t,!d)}),[d,j,t]),k=Object(he.a)(new Date(p),new Date);return r.createElement("div",{className:Le.a.body},r.createElement(J,{name:t,toggle:w,type:s,isOpen:d,qty:b.length}),r.createElement("div",{className:Le.a.updatedAt},r.createElement("small",null,"Updated ",k," ago")),r.createElement(Be,{isOpen:d},r.createElement(me,{all:b}),r.createElement("div",{className:Le.a.actionFooter},r.createElement(m.a,{text:"Update",start:r.createElement(Me,null),onClick:x}),r.createElement(m.a,{text:"Health Check",start:r.createElement(l.a,{size:16}),onClick:g,isLoading:h}))),r.createElement(Be,{isOpen:!d},r.createElement(pe,{all:b})))}));function Ke(e){var t=e.items;return 0===t.length?null:r.createElement(r.Fragment,null,r.createElement(p.a,{title:"Proxy Provider"}),r.createElement("div",null,t.map((function(e){return r.createElement(Ue,{key:e.name,name:e.name,proxies:e.proxies,type:e.type,vehicleType:e.vehicleType,updatedAt:e.updatedAt})}))))}var Te=n("UVHL"),Je=n.n(Te);function qe(e){var t=e.options,n=e.selected,c=e.onChange;return r.createElement("select",{className:Je.a.select,value:n,onChange:c},t.map((function(e){var t=Object(a.a)(e,2),n=t[0],c=t[1];return r.createElement("option",{key:n,value:n},c)})))}var ze=n("hkBY"),Ie=n("5JRb"),Ze=n.n(Ie),Fe=[["Natural","Original order in config file"],["LatencyAsc","By latency from small to big"],["LatencyDesc","By latency from big to small"],["NameAsc","By name alphabetically (A-Z)"],["NameDesc","By name alphabetically (Z-A)"]],He=r.useCallback;var Ve=Object(C.a)((function(e){return{appConfig:{proxySortBy:Object(i.g)(e),hideUnavailableProxies:Object(i.e)(e),autoCloseOldConns:Object(i.b)(e)}}}))((function(e){var t=e.appConfig,n=Object(C.c)().app.updateAppConfig,a=He((function(e){n("proxySortBy",e.target.value)}),[n]),c=He((function(e){n("hideUnavailableProxies",e)}),[n]);return r.createElement(r.Fragment,null,r.createElement("div",{className:Ze.a.labeledInput},r.createElement("span",null,"Sorting in group"),r.createElement("div",null,r.createElement(qe,{options:Fe,selected:t.proxySortBy,onChange:a}))),r.createElement("hr",null),r.createElement("div",{className:Ze.a.labeledInput},r.createElement("span",null,"Hide unavailable proxies"),r.createElement("div",null,r.createElement(ze.a,{name:"hideUnavailableProxies",checked:t.hideUnavailableProxies,onChange:c}))),r.createElement("div",{className:Ze.a.labeledInput},r.createElement("span",null,"Automatically close old connections"),r.createElement("div",null,r.createElement(ze.a,{name:"autoCloseOldConns",checked:t.autoCloseOldConns,onChange:function(e){return n("autoCloseOldConns",e)}}))))})),Ge=n("LhcJ"),We=n("DsEz"),Ye=n.n(We);function Xe(){var e=Object(Ge.a)(u.k),t=Object(a.a)(e,2),n=t[0],c=t[1];return r.createElement("input",{className:Ye.a.input,type:"text",value:c,onChange:n})}var Qe=r.useState,$e=r.useEffect,et=r.useCallback,tt=r.useRef;function nt(){return r.createElement("div",{className:P.a.spining,style:{width:48,height:48,display:"flex",justifyContent:"center",alignItems:"center"}},r.createElement(l.a,{width:16,height:16}))}t.default=Object(C.a)((function(e){return{apiConfig:Object(i.c)(e),groupNames:Object(u.f)(e),proxyProviders:Object(u.g)(e),delay:Object(u.d)(e),showModalClosePrevConns:Object(u.h)(e),mode:Object(s.b)(e).mode.toUpperCase()}}))((function(e){var t=e.dispatch,n=e.groupNames,c=e.delay,i=e.proxyProviders,s=e.apiConfig,d=e.showModalClosePrevConns,f=e.mode,v=tt({}),b=Qe(!1),y=Object(a.a)(b,2),E=y[0],h=y[1],O=et((function(){E||(h(!0),t(Object(u.l)(s)).then((function(){return h(!1)}),(function(){return h(!1)})))}),[s,t,E]),w=et((function(){v.current.startAt=Date.now(),t(Object(u.c)(s)).then((function(){v.current.completeAt=Date.now()}))}),[s,t]);$e((function(){w();var e=function(){v.current.startAt&&Date.now()-v.current.startAt>3e4&&w()};return window.addEventListener("focus",e,!1),function(){return window.removeEventListener("focus",e,!1)}}),[w]);var k=Qe(!1),N=Object(a.a)(k,2),S=N[0],B=N[1],L=et((function(){B(!1)}),[]),R=Object(C.c)().proxies,A=R.closeModalClosePrevConns,D=R.closePrevConnsAndTheModal,M=Object(o.a)().t,U=[];if(Object.assign(U,n),"RULE"===f||"DIRECT"===f){var K=U.indexOf("GLOBAL");K>-1&&U.splice(K,1)}else{var T=U.indexOf("GLOBAL");T>-1&&(U.splice(0,T),U.splice(T,T+1))}return r.createElement(r.Fragment,null,r.createElement(x,{isOpen:S,onRequestClose:L},r.createElement(Ve,null)),r.createElement("div",{className:P.a.topBar},r.createElement(p.a,{title:M("Proxies")}),r.createElement("div",{className:P.a.topBarRight},r.createElement("div",{className:P.a.textFilterContainer},r.createElement(Xe,null)),r.createElement(m.a,{kind:"minimal",onClick:function(){return B(!0)}},r.createElement(j,{size:16})))),r.createElement("div",null,U.map((function(e){return r.createElement("div",{className:P.a.group,key:e},r.createElement(Ee,{name:e,delay:c,apiConfig:s,dispatch:t}))}))),r.createElement(Ke,{items:i}),r.createElement("div",{style:{height:60}}),r.createElement(g.b,{icon:E?r.createElement(nt,null):r.createElement(l.a,{width:16,height:16}),onClick:O,text:M("Test Latency"),position:g.c}),r.createElement(x,{isOpen:d,onRequestClose:A},r.createElement(_,{onClickPrimaryButton:function(){return D(s)},onClickSecondaryButton:A})))}))},wztZ:function(e,t,n){e.exports={proxy:"_1OypGPFF1I",now:"_25Vy0R3DBh",error:"_20b8CxdJZg",selectable:"_2jncDUnzU1",proxyType:"_3ILPKOrew2",row:"_3DtTZsIYVP",proxyName:"_2dGvkUlaDx",proxySmall:"_1fX-k2HS41"}},xKoM:function(e,t,n){e.exports={header:"WqD74l0KeZ",zapWrapper:"_3u5R6urbB9"}}}]);