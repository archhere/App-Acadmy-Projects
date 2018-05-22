// function sum(){
//   let sum = 0;
//   const args = Array.from(arguments);
//   args.forEach( el=> sum += el );
//   return sum;
// }
// 
// function rest_sum(...args){
//   let sum = 0;
//   args.forEach( el=> sum += el );
//   return sum;
// }
// 
// Function.prototype.myBind = function(){
//     let ctx = arguments[0];
//     let args = Array.from(arguments);
//     let args2 = args.slice(1); 
//     let that = this;  
//     return function() {
//         let callTimeArg = Array.from(arguments);
//         that.apply(ctx, args2);
//     };
//   };

  Function.prototype.myBind = function(ctx,...bindArgs){
    return (...callArgs)=>{
    this.apply(ctx,bindArgs.concat(callArgs));
    };
  };
    
  
  
  
  class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}

const markov = new Cat("Markov");
const breakfast = new Cat("Breakfast");

markov.says("meow", "Ned");
// Markov says meow to Ned!
// true

// bind time args are "meow" and "Kush", no call time args
markov.says.myBind(breakfast, "meow", "Kush")();
// Breakfast says meow to Kush!
// true

// no bind time args (other than context), call time args are "meow" and "me"
markov.says.myBind(breakfast)("meow", "a tree");
// Breakfast says meow to a tree!
// true

// bind time arg is "meow", call time arg is "Markov"
markov.says.myBind(breakfast, "meow")("Markov");
// Breakfast says meow to Markov!
// true

// no bind time args (other than context), call time args are "meow" and "me"
const notMarkovSays = markov.says.myBind(breakfast);
notMarkovSays("meow", "me");
// Breakfast says meow to me!
// true

  
  --------------------------------------------------------------------------------
  
    function curriedSum(numArgs) {
      let numbers = [];

      return function _curriedSum(num){
        numbers.push(num);

        if (numbers.length === numArgs) {
          return numbers.reduce( (acc,el) => acc + el );
        }
        else {
          return _curriedSum;
        }
      };


      // return _curriedSum;
    }

    // --------------------------------------------------------------------------------

    // 
    Function.prototype.curry = function (numArgs) {
      let func = this;
      let numbers = [];    

      return function _curried(num){
        numbers.push(num);

        if (numbers.length === numArgs) {
          return func(...numbers);
        }
        else {
          return _curried;
        }
      };

    };


    Function.prototype.curry = function (numArgs) {
      let that = this;
      let numbers = [];    

      return function _curried(num){
        numbers.push(num);

        if (numbers.length === numArgs) {
          return that.apply(null, numbers);
        }
        else {
          return _curried;
        }
      };

    };


function add() { 
  numbers = Array.from(arguments);
  return numbers.reduce( (acc,el) => acc + el );
}


function multiply() { 
  numbers = Array.from(arguments);
  return numbers.reduce( (acc,el) => acc * el );
}



