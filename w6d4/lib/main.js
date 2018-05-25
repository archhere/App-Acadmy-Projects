const DOMNodeCollection = require('./dom_node_collection.js');

const $l = (arg) => {
  if (arg instanceof HTMLElement) {
    return new DOMNodeCollection([arg]);
  } else if (arg instanceof Function) {
    document.addEventListener("DOMContentLoaded", function(event) {
      arg(event);
    });
  } else {
    let query = document.querySelectorAll(arg);
    return new DOMNodeCollection(Array.from(query));

  }
};

window.$l = $l;



console.log($l("ul"));


$l( ()=> console.log($l("ul")) );
