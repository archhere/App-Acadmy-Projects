
class DOMNodeCollection {

  constructor(array){
    this.array = array;
  }

  html(string) {
    if (string === undefined) {
      return this.array[0].innerHTML;
    } else {
      this.array.forEach((ar)=>{
        ar.innerHTML = string;
      });
    }
  }

  empty() {
    this.html("");
  }

  append(arg) {
    if (arg instanceof HTMLElement){
      this.array.forEach((el)=>{
        el.innerHTML += arg.outerHTML;
      });
    } else if (arg.constructor.name === "DOMNodeCollection") {
      this.array.forEach((parent)=>{
        arg.array.forEach((child)=>{
          parent.innerHTML += child.outerHTML;
        });
      });
    } else {
      this.array.forEach((el)=>{
        el.innerHTML += arg;
      });
    }
  }

  children(){
    let child = [];
    this.array.forEach((el)=>{
      Array.from(el.children).forEach((el2)=>{
        child.push(el2);
      });
    });
    return new DOMNodeCollection(child);
  }

  parent(){
    let parents = [];
    this.array.forEach((el)=>{
      parents.push(el.parentElement);
    });
    return new DOMNodeCollection(parents);
  }

  find(arg) {
    let query = document.querySelectorAll(arg);
    let qu = Array.from(query).filter((el)=> this.children().array.includes(el));
    return new DOMNodeCollection(qu);
  }

  remove() {
    this.empty();
  }

  on(action, callback) {
    this.array.forEach((el)=>{
      el.addEventListener(action, callback);
      el.callback = callback;
    });
  }

  off(action) {
    this.array.forEach((el)=>{
      el.removeEventListener(action, el.callback);
    });
  }

}






module.exports = DOMNodeCollection;
