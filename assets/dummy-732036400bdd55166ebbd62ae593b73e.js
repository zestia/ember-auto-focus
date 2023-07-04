"use strict"
define("dummy/app",["exports","@ember/application","ember-resolver","ember-load-initializers","dummy/config/environment"],(function(e,t,i,r,n){function o(e,t,i){return(t=function(e){var t=function(e,t){if("object"!=typeof e||null===e)return e
var i=e[Symbol.toPrimitive]
if(void 0!==i){var r=i.call(e,t||"default")
if("object"!=typeof r)return r
throw new TypeError("@@toPrimitive must return a primitive value.")}return("string"===t?String:Number)(e)}(e,"string")
return"symbol"==typeof t?t:String(t)}(t))in e?Object.defineProperty(e,t,{value:i,enumerable:!0,configurable:!0,writable:!0}):e[t]=i,e}Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0
class u extends t.default{constructor(){super(...arguments),o(this,"modulePrefix",n.default.modulePrefix),o(this,"podModulePrefix",n.default.podModulePrefix),o(this,"Resolver",i.default)}}e.default=u,(0,r.default)(u,n.default.modulePrefix)})),define("dummy/component-managers/glimmer",["exports","@glimmer/component/-private/ember-component-manager"],(function(e,t){Object.defineProperty(e,"__esModule",{value:!0}),Object.defineProperty(e,"default",{enumerable:!0,get:function(){return t.default}})})),define("dummy/controllers/modifier",["exports","@ember/controller","@glimmer/tracking"],(function(e,t,i){var r,n
function o(e,t,i){return(t=function(e){var t=function(e,t){if("object"!=typeof e||null===e)return e
var i=e[Symbol.toPrimitive]
if(void 0!==i){var r=i.call(e,t||"default")
if("object"!=typeof r)return r
throw new TypeError("@@toPrimitive must return a primitive value.")}return("string"===t?String:Number)(e)}(e,"string")
return"symbol"==typeof t?t:String(t)}(t))in e?Object.defineProperty(e,t,{value:i,enumerable:!0,configurable:!0,writable:!0}):e[t]=i,e}Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0
let u=(r=class extends t.default{constructor(){var e,t,i,r
super(...arguments),e=this,t="shouldShowInput",r=this,(i=n)&&Object.defineProperty(e,t,{enumerable:i.enumerable,configurable:i.configurable,writable:i.writable,value:i.initializer?i.initializer.call(r):void 0}),o(this,"showInput",(()=>{this.shouldShowInput=!0})),o(this,"hideInput",(()=>{this.shouldShowInput=!1}))}},l=r.prototype,a="shouldShowInput",d=[i.tracked],f={configurable:!0,enumerable:!0,writable:!0,initializer:function(){return!1}},s={},Object.keys(f).forEach((function(e){s[e]=f[e]})),s.enumerable=!!s.enumerable,s.configurable=!!s.configurable,("value"in s||s.initializer)&&(s.writable=!0),s=d.slice().reverse().reduce((function(e,t){return t(l,a,e)||e}),s),c&&void 0!==s.initializer&&(s.value=s.initializer?s.initializer.call(c):void 0,s.initializer=void 0),void 0===s.initializer&&(Object.defineProperty(l,a,s),s=null),n=s,r)
var l,a,d,f,c,s
e.default=u})),define("dummy/controllers/native",["exports","@ember/controller","@glimmer/tracking"],(function(e,t,i){var r,n
function o(e,t,i){return(t=function(e){var t=function(e,t){if("object"!=typeof e||null===e)return e
var i=e[Symbol.toPrimitive]
if(void 0!==i){var r=i.call(e,t||"default")
if("object"!=typeof r)return r
throw new TypeError("@@toPrimitive must return a primitive value.")}return("string"===t?String:Number)(e)}(e,"string")
return"symbol"==typeof t?t:String(t)}(t))in e?Object.defineProperty(e,t,{value:i,enumerable:!0,configurable:!0,writable:!0}):e[t]=i,e}Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0
let u=(r=class extends t.default{constructor(){var e,t,i,r
super(...arguments),e=this,t="shouldShowInput",r=this,(i=n)&&Object.defineProperty(e,t,{enumerable:i.enumerable,configurable:i.configurable,writable:i.writable,value:i.initializer?i.initializer.call(r):void 0}),o(this,"showInput",(()=>{this.shouldShowInput=!0})),o(this,"hideInput",(()=>{this.shouldShowInput=!1}))}},l=r.prototype,a="shouldShowInput",d=[i.tracked],f={configurable:!0,enumerable:!0,writable:!0,initializer:function(){return!1}},s={},Object.keys(f).forEach((function(e){s[e]=f[e]})),s.enumerable=!!s.enumerable,s.configurable=!!s.configurable,("value"in s||s.initializer)&&(s.writable=!0),s=d.slice().reverse().reduce((function(e,t){return t(l,a,e)||e}),s),c&&void 0!==s.initializer&&(s.value=s.initializer?s.initializer.call(c):void 0,s.initializer=void 0),void 0===s.initializer&&(Object.defineProperty(l,a,s),s=null),n=s,r)
var l,a,d,f,c,s
e.default=u})),define("dummy/helpers/page-title",["exports","ember-page-title/helpers/page-title"],(function(e,t){Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0
var i=t.default
e.default=i})),define("dummy/initializers/container-debug-adapter",["exports","ember-resolver/resolvers/classic/container-debug-adapter"],(function(e,t){Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0
var i={name:"container-debug-adapter",initialize(){(arguments[1]||arguments[0]).register("container-debug-adapter:main",t.default)}}
e.default=i})),define("dummy/modifiers/auto-focus",["exports","@zestia/ember-auto-focus/modifiers/auto-focus"],(function(e,t){Object.defineProperty(e,"__esModule",{value:!0}),Object.defineProperty(e,"default",{enumerable:!0,get:function(){return t.default}})})),define("dummy/router",["exports","@ember/routing/router","dummy/config/environment"],(function(e,t,i){function r(e,t,i){return(t=function(e){var t=function(e,t){if("object"!=typeof e||null===e)return e
var i=e[Symbol.toPrimitive]
if(void 0!==i){var r=i.call(e,t||"default")
if("object"!=typeof r)return r
throw new TypeError("@@toPrimitive must return a primitive value.")}return("string"===t?String:Number)(e)}(e,"string")
return"symbol"==typeof t?t:String(t)}(t))in e?Object.defineProperty(e,t,{value:i,enumerable:!0,configurable:!0,writable:!0}):e[t]=i,e}Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0
class n extends t.default{constructor(){super(...arguments),r(this,"location",i.default.locationType),r(this,"rootURL",i.default.rootURL)}}e.default=n,n.map((function(){this.route("native"),this.route("modifier")}))})),define("dummy/routes/index",["exports","@ember/routing/route","@ember/service"],(function(e,t,i){var r,n
Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0
let o=(r=class extends t.default{constructor(){var e,t,i,r
super(...arguments),e=this,t="router",r=this,(i=n)&&Object.defineProperty(e,t,{enumerable:i.enumerable,configurable:i.configurable,writable:i.writable,value:i.initializer?i.initializer.call(r):void 0})}redirect(){return this.router.transitionTo("modifier")}},u=r.prototype,l="router",a=[i.inject],d={configurable:!0,enumerable:!0,writable:!0,initializer:null},c={},Object.keys(d).forEach((function(e){c[e]=d[e]})),c.enumerable=!!c.enumerable,c.configurable=!!c.configurable,("value"in c||c.initializer)&&(c.writable=!0),c=a.slice().reverse().reduce((function(e,t){return t(u,l,e)||e}),c),f&&void 0!==c.initializer&&(c.value=c.initializer?c.initializer.call(f):void 0,c.initializer=void 0),void 0===c.initializer&&(Object.defineProperty(u,l,c),c=null),n=c,r)
var u,l,a,d,f,c
e.default=o})),define("dummy/services/page-title-list",["exports","ember-page-title/services/page-title-list"],(function(e,t){Object.defineProperty(e,"__esModule",{value:!0}),Object.defineProperty(e,"default",{enumerable:!0,get:function(){return t.default}})})),define("dummy/services/page-title",["exports","ember-page-title/services/page-title"],(function(e,t){Object.defineProperty(e,"__esModule",{value:!0}),Object.defineProperty(e,"default",{enumerable:!0,get:function(){return t.default}})})),define("dummy/templates/application",["exports","@ember/template-factory"],(function(e,t){Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0
var i=(0,t.createTemplateFactory)({id:"vfwbMskp",block:'[[[10,"h1"],[12],[1,"\\n  @zestia/ember-auto-focus\\n"],[13],[1,"\\n\\n"],[8,[39,0],null,[["@route"],["native"]],[["default"],[[[[1,"\\n  Native\\n"]],[]]]]],[1,"\\n|\\n"],[8,[39,0],null,[["@route"],["modifier"]],[["default"],[[[[1,"\\n  Modifier\\n"]],[]]]]],[1,"\\n\\n"],[10,"br"],[12],[13],[1,"\\n"],[10,"br"],[12],[13],[1,"\\n\\n"],[46,[28,[37,2],null,null],null,null,null],[1,"\\n\\n"],[10,3],[14,6,"https://github.com/zestia/ember-auto-focus"],[12],[1,"\\n  "],[10,"img"],[14,5,"position: absolute; top: 0; right: 0; border: 0;"],[14,"width","149"],[14,"height","149"],[14,"src","https://github.blog/wp-content/uploads/2008/12/forkme_right_darkblue_121621.png?resize=149%2C149"],[14,0,"attachment-full size-full"],[14,"alt","Fork me on GitHub"],[14,"data-recalc-dims","1"],[12],[13],[1,"\\n"],[13]],[],false,["link-to","component","-outlet"]]',moduleName:"dummy/templates/application.hbs",isStrictMode:!1})
e.default=i})),define("dummy/templates/modifier",["exports","@ember/template-factory"],(function(e,t){Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0
var i=(0,t.createTemplateFactory)({id:"IA36OZ9v",block:'[[[41,[30,0,["shouldShowInput"]],[[[1,"  "],[10,2],[12],[1,"\\n    "],[11,"input"],[24,"aria-label","Example text input"],[4,[38,1],null,null],[12],[13],[1,"\\n  "],[13],[1,"\\n"]],[]],null],[1,"\\n"],[10,"code"],[12],[1,"\\n  <input "],[1,"{{auto-focus}}>\\n"],[13],[1,"\\n\\n"],[10,2],[12],[1,"\\n  Notice that on the second render, the input\\n  "],[10,"em"],[12],[1,"\\n    is\\n  "],[13],[1,"\\n  focused.\\n"],[13],[1,"\\n\\n"],[10,2],[12],[1,"\\n  "],[11,"button"],[24,4,"button"],[4,[38,2],["click",[30,0,["showInput"]]],null],[12],[1,"\\n    Show input\\n  "],[13],[1,"\\n  "],[11,"button"],[24,4,"button"],[4,[38,2],["click",[30,0,["hideInput"]]],null],[12],[1,"\\n    Hide input\\n  "],[13],[1,"\\n"],[13]],[],false,["if","auto-focus","on"]]',moduleName:"dummy/templates/modifier.hbs",isStrictMode:!1})
e.default=i})),define("dummy/templates/native",["exports","@ember/template-factory"],(function(e,t){Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0
var i=(0,t.createTemplateFactory)({id:"1R6FbELz",block:'[[[41,[30,0,["shouldShowInput"]],[[[1,"  "],[10,2],[12],[1,"\\n"],[1,"    "],[10,"input"],[14,"aria-label","Example text input"],[14,"autofocus",""],[12],[13],[1,"\\n  "],[13],[1,"\\n"]],[]],null],[1,"\\n"],[10,"code"],[12],[1,"\\n  <input autofocus>\\n"],[13],[1,"\\n\\n"],[10,2],[12],[1,"\\n  Notice that on the second render, the input\\n  "],[10,"em"],[12],[1,"\\n    is not\\n  "],[13],[1,"\\n  focused.\\n"],[13],[1,"\\n\\n"],[10,2],[12],[1,"\\n  "],[11,"button"],[24,4,"button"],[4,[38,1],["click",[30,0,["showInput"]]],null],[12],[1,"\\n    Show input\\n  "],[13],[1,"\\n  "],[11,"button"],[24,4,"button"],[4,[38,1],["click",[30,0,["hideInput"]]],null],[12],[1,"\\n    Hide input\\n  "],[13],[1,"\\n"],[13]],[],false,["if","on"]]',moduleName:"dummy/templates/native.hbs",isStrictMode:!1})
e.default=i})),define("dummy/config/environment",[],(function(){try{var e="dummy/config/environment",t=document.querySelector('meta[name="'+e+'"]').getAttribute("content"),i={default:JSON.parse(decodeURIComponent(t))}
return Object.defineProperty(i,"__esModule",{value:!0}),i}catch(r){throw new Error('Could not read config from meta tag with name "'+e+'".')}})),runningTests||require("dummy/app").default.create({})
