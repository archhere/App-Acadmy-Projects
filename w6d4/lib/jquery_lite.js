/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./lib/main.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./lib/dom_node_collection.js":
/*!************************************!*\
  !*** ./lib/dom_node_collection.js ***!
  \************************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("\nclass DOMNodeCollection {\n\n  constructor(array){\n    this.array = array;\n  }\n\n  html(string) {\n    if (string === undefined) {\n      return this.array[0].innerHTML;\n    } else {\n      this.array.forEach((ar)=>{\n        ar.innerHTML = string;\n      });\n    }\n  }\n\n  empty() {\n    this.html(\"\");\n  }\n\n  append(arg) {\n    if (arg instanceof HTMLElement){\n      this.array.forEach((el)=>{\n        el.innerHTML += arg.outerHTML;\n      });\n    } else if (arg.constructor.name === \"DOMNodeCollection\") {\n      this.array.forEach((parent)=>{\n        arg.array.forEach((child)=>{\n          parent.innerHTML += child.outerHTML;\n        });\n      });\n    } else {\n      this.array.forEach((el)=>{\n        el.innerHTML += arg;\n      });\n    }\n  }\n\n  children(){\n    let child = [];\n    this.array.forEach((el)=>{\n      Array.from(el.children).forEach((el2)=>{\n        child.push(el2);\n      });\n    });\n    return new DOMNodeCollection(child);\n  }\n\n  parent(){\n    let parents = [];\n    this.array.forEach((el)=>{\n      parents.push(el.parentElement);\n    });\n    return new DOMNodeCollection(parents);\n  }\n\n  find(arg) {\n    let query = document.querySelectorAll(arg);\n    let qu = Array.from(query).filter((el)=> this.children().array.includes(el));\n    return new DOMNodeCollection(qu);\n  }\n\n  remove() {\n    this.empty();\n  }\n\n  on(action, callback) {\n    this.array.forEach((el)=>{\n      el.addEventListener(action, callback);\n      el.callback = callback;\n    });\n  }\n\n  off(action) {\n    this.array.forEach((el)=>{\n      el.removeEventListener(action, el.callback);\n    });\n  }\n\n}\n\n\n\n\n\n\nmodule.exports = DOMNodeCollection;\n\n\n//# sourceURL=webpack:///./lib/dom_node_collection.js?");

/***/ }),

/***/ "./lib/main.js":
/*!*********************!*\
  !*** ./lib/main.js ***!
  \*********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const DOMNodeCollection = __webpack_require__(/*! ./dom_node_collection.js */ \"./lib/dom_node_collection.js\");\n\nconst $l = (arg) => {\n  if (arg instanceof HTMLElement) {\n    return new DOMNodeCollection([arg]);\n  } else if (arg instanceof Function) {\n    document.addEventListener(\"DOMContentLoaded\", function(event) {\n      arg(event);\n    });\n  } else {\n    let query = document.querySelectorAll(arg);\n    return new DOMNodeCollection(Array.from(query));\n\n  }\n};\n\nwindow.$l = $l;\n\n\n\nconsole.log($l(\"ul\"));\n\n\n$l( ()=> console.log($l(\"ul\")) );\n\n\n//# sourceURL=webpack:///./lib/main.js?");

/***/ })

/******/ });