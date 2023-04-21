var __ember_auto_import__;(()=>{var e={304:(e,t,n)=>{"use strict"
n.r(t),n.d(t,{default:()=>c,modifier:()=>l})
const r=require("@ember/application"),o=require("@ember/modifier"),i=require("@ember/destroyable")
function a(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}class s{constructor(e){this.owner=e,a(this,"capabilities",(0,o.capabilities)("3.22"))}createModifier(e,t){return{instance:new e(this.owner,t),element:null}}installModifier(e,t,n){const r=function(e,t){const n=e
return n.element=t,n}(e,t)
r.instance.modify(t,n.positional,n.named)}updateModifier(e,t){e.instance.modify(e.element,t.positional,t.named)}destroyModifier(e){let{instance:t}=e;(0,i.destroy)(t)}}class c{constructor(e,t){(0,r.setOwner)(this,e)}modify(e,t,n){}}(0,o.setModifierManager)((e=>new s(e)),c)
const d=new class{constructor(){a(this,"capabilities",(0,o.capabilities)("3.22"))}createModifier(e){return{element:null,instance:e}}installModifier(e,t,n){const r=function(e,t){const n=e
return n.element=t,n}(e,t),{positional:o,named:i}=n,a=e.instance(t,o,i)
"function"==typeof a&&(r.teardown=a)}updateModifier(e,t){"function"==typeof e.teardown&&e.teardown()
const n=e.instance(e.element,t.positional,t.named)
"function"==typeof n&&(e.teardown=n)}destroyModifier(e){"function"==typeof e.teardown&&e.teardown()}}
function l(e){return(0,o.setModifierManager)((()=>d),e)}},104:(e,t,n)=>{var r,o
e.exports=(r=_eai_d,o=_eai_r,window.emberAutoImportDynamic=function(e){return 1===arguments.length?o("_eai_dyn_"+e):o("_eai_dynt_"+e)(Array.prototype.slice.call(arguments,1))},window.emberAutoImportSync=function(e){return o("_eai_sync_"+e)(Array.prototype.slice.call(arguments,1))},r("__v1-addons__early-boot-set__",[],(function(){})),void r("ember-modifier",["__v1-addons__early-boot-set__"],(function(){return n(304)})))},670:function(e,t){window._eai_r=require,window._eai_d=define}},t={}
function n(r){var o=t[r]
if(void 0!==o)return o.exports
var i=t[r]={exports:{}}
return e[r].call(i.exports,i,i.exports,n),i.exports}n.d=(e,t)=>{for(var r in t)n.o(t,r)&&!n.o(e,r)&&Object.defineProperty(e,r,{enumerable:!0,get:t[r]})},n.o=(e,t)=>Object.prototype.hasOwnProperty.call(e,t),n.r=e=>{"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},n(670)
var r=n(104)
__ember_auto_import__=r})()
