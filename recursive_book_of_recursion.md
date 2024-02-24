# The Recursive Book of Recursion:

## Intro

- Despite its reputation for being challenging, recursion is an important computer science topic that yields keen insights into programming itself.
- Widespread misunderstanding of recursion is poor instruction rather than inherent difficulty.
- Recursion can be overused in cases where a simpler solution exists. Recursive algos can be hard to understand, have worse performance, and are susceptible to crash-causing stack overflow errors.

## Chapter 1: What is recursion?

- At its core it depends on only two things: function calls and stack data structures.
- Call stack - a data structure that controls the program’s flow of execution
- A recursive thing is something whose definition includes itself. That is, it has a self-referential definition.
- Functions can be described as mini-programs inside your program.
    - If you need to run identical instructions three different places in the program, instead of copy and pasting the source code three times, you can write the coe in a function once and call the function three times. This creates shorter and more readable programs.
    - All programming languages have the same four features in their functions:
        1. Functions have code that is run when the function is called.
        2. Arguments are passed to the function when it’s called. This is the input to the function and functions can have zero or more arguments.
        3. Functions return a return value. This is the output of the function, though some programming languages allow functions no to return anything or to return null values like undefined or non.
        4. The program remembers which like of code called the function and returns to it when the function finishes its execution.
- The below demonstrates behavior that is determined by the call stack:

```jsx
function a() {
    console.log("a() was called")
    b()
    console.log("a() is returning")
}

function b()  {
    console.log("b() was called")
    c()
    console.log("b() is returning")
}

function c() {
    console.log("c() was called")
    console.log("c() is returning")
}

a()

/*Output:
a() was called
b() was called
c() was called
c() is returning
b() is returning
a() is returning
*/
```

### Call Stacks

- To understand recursion you must first understand stacks.
- A stack is ony of the most simple data structures in computer science. It stores multiple values lik a list does — but it limits you to adding or removing values from the “top of the stack” only.
    - For stacks implemented with lists or arrays, the “top” is the last item, at the right end of the list or array. Adding values is called pushing values into the stack, while removing them is called popping the values off the stack.

```jsx
let cardStack = []

cardStack.push('5 of diamonds')
console.log(cardStack)
cardStack.push("3 of clubs")
console.log(cardStack)
cardStack.push("ace of hearts")
console.log(cardStack)
cardStack.pop()
console.log(cardStack)

/*
[ '5 of diamonds' ]
[ '5 of diamonds', '3 of clubs' ]
[ '5 of diamonds', '3 of clubs', 'ace of hearts' ]
[ '5 of diamonds', '3 of clubs' ]
*/
```

- Stacks are a LIFO data structure, last in first out, since the last value pushed onto the stack is the first one popped out of it.
- The program’s call stack, simply called the stack, is a stack of frame objects. Frame objects, also simply called frames, contain information about a single function call, including which line of code called the function, so the execution can move back there when the function returns.
- Frame objects are created and pushed onto the stack when a function is called. When the function returns, the frame object is popped off the stack.
    - If we call a function that calls a function that calls a function, the call stack will have three frame objects on the stack. When all these functions return, the call stack will have zero frame objects on the stack.
    - Programming languages generally handle frame objects automatically.
    - Frame objects generally contain the following:
        - the return address, or the spot in the program where the execution should move to when the function returns
        - the arguments passed to the function call
        - a set of local variables created during the function call.

```jsx
function a(){
    let spam = "Ant"
    console.log(`spam is ${spam}`)
    b()
    console.log(`spam is ${spam}`)
}

function b(){
    let spam = "Bobcat"
    console.log(`spam is ${spam}`)
    c()
    console.log(`spam is ${spam}`)
}

function c(){
    let spam = "Coyote"
    console.log(`spam is ${spam}`)
}

a()

/* returns
spam is Ant
spam is Bobcat
spam is Coyote
spam is Bobcat
spam is Ant
*/
```

- When the program above calls `a()` , a frame object is created and placed on top of the call stack. This frame stores any arguments passed to `a()` , along with the local variable `spam` , and the place where the execution should go when the `a()` function returns.
    
    When `a()` is called, it displays its local spam variable is `spam`, The `b()` function call has its own local `spam` variable and then calls `c()` which also has it’s own variable. When `c()` returns, the fram objects pop off the all stack,. The program execution knows where to return to because it is store in the frame object.
    
- Every running program has a call stack, and multithreaded programs have one call stack for each thread. But when you look at the source code for a program, you can’t see the call stack in the code. The call stack isn’t stored in a variable as other data structures are; it’s automatically handled in the background.
- Recursion relies on the call stack — which cannot be seen, that’s one of the reasons why it’s so mysterious.

### What Are Recursive Functions and Stack Overflows?

- A recursive function is a function that calls itself:

```jsx
function shortest() {
	shortest()
}
shortest()
```

- The above function will do nothing but call the `shortest()` function. Since the call stack uses the computer’s finite memory, the program cannot continue forever. The only thing this program can do is crash and display an error message.
- This kind of bug is a called a *stack overflow*. The constant function calls with no returns grow the call stack until all the computer’s memory allocated for the call stack is used up. To prevent this Python and JS interpreters crash the program after a certain limit.

## Base Cases and Recursive Cases

- To avoid a crash, there needs to be a case, or set of circumstances, where the function stops calling itself and instead just returns. This called the *base case*.

```jsx
function shortestWithBaseCase(makeRecurseriveCall){
    console.log(`shortestWithBaseCase ${makeRecurseriveCall} called` )
    if (makeRecurseriveCall === false) {
        //base case
        console.log(`returning from base case`)
    } else {
        shortestWithBaseCase(false)
        console.log(`returning form recursive case`)
        return
    }
}

console.log(`calling shortestWithBaseCase(false):`)
shortestWithBaseCase(false)
console.log(`shortestWithBaseCase(true)`)
shortestWithBaseCase(true)

/*
calling shortestWithBaseCase(false):
shortestWithBaseCase false called
returning from base case
shortestWithBaseCase(true)
shortestWithBaseCase true called
shortestWithBaseCase false called
returning from base case
returning form recursive case
*/
```

## Code Before & After the Recursive Call

- Code in a recursive case can be split into 1) the code before the recursive call and 2) the code after the recursive call.
- Reaching the base case doesn’t necessarily mean reaching the end of the recursive algorithm. It only means that it will stop making recursive calls.

```jsx
function countDownAndUp(number) {
    console.log(number)
    if (number === 0){
        //base case
        console.log(`reached the base case`)
        return
    } else {
        countDownAndUp(number - 1) 
        console.log(`${number} returning`)
        return
    }
}
countDownAndUp(3)

/*
3
2
1
0
reached the base case
1 returning
2 returning
3 returning
*/
```

- Every time a function is called, a new frame is created and pushed onto the call stack. There is a separate number variable for each frame on the call stack.
- The pattern of making consecutive recursive calls and then returning  from the recursive calls is what causes the countdown of numbers to appear. Once the base case is reached — no more recursive callsare made. However this isn’t the end of the program.
- When the base case is reached, the local `number` variable is 0 — but when the base case returns the frame is popped off the call stack, the frame under it has its own local `number` . As the execution returns back to the previous frames in the call stack, the code *after* the recursive call is executed, this is what causes numbers to count back up.
- The fact that the code doesn’t stop immediately when the base case is reached will be important to keep in mind for the factorial example later. Any code after the recursive case will still have to run.
- If you find yourself asking — wouldn’t a loop be easier, it probably is. Recursive code isn’t automatically “better” or “more elegant”. On some occasions an algorithm cleanly maps to a recursive approach. Algos that involve tree-like data structures and require backtracking are especially suited for recursion.

### Take-aways

1. Recursion often confuses new programmers, but it is built on the simple idea that a function can call itself.  
2. Every time a function call is made, a new frame object with information related to the call (such as local variables and a return address for the execution to move to when the function returns) is added to the call stack.
3. The call stack is stack data structure that can be altered only by have data added or removed from tis top. This is called pushing to and popping from the stack — respectively.
4. The call stack is handled by the program implicitly, so there is no call stack variable. Calling a function pushes a frame object to the call stack, and returning from a function pops a fram object from the call stack.
5. Recursive functions have recursive cases, those in which a recursive call is made, and base cases, those where the function simply returns. If there is no base case or a bug prevents a base case from being run, the execution causes a stack overflow that crashes the program.

## Recursion vs. Iteration

- Neither technique is superior. Any recursive code can be written as iterative code with a loop and a stack. Any iterative loop can be rewritten as a recursive function.

### Calculating Factorials

- The factorial of an integer, is the product of all integers 1 to n.
- Iterative factorials are relatively simple, straightforward and get the job done:

```jsx
//Iterative Factoria
function findFactorial(n) {
    let product = 1
    for (let i = 1; i <=n; i++) {
        product *= i
    } 
    return product
}

console.log(findFactorial(5))
ff
```

- You can say 5! = 5*4! — this is recursive because the definition of the factorial 5 includes the definition of factorial 4 (n-1).

```jsx
//Recursive Factorial

function findFactorial(n){
    if (n === 0) return 1
    return n * findFactorial(n-1)
}
console.log(findFactorial(5))
//returns 120
```

- The confusion arises because the recursive case has one line, half of which is executed before the recursive call, and half of which takes place after recursive call returns. We aren’t used to the idea of only half of a line of code executing at a time.
    - The first half is `factorial(n-1)` . This involves calculating `n-1` and making a recursive function, causing a new frame object to be pushed to the call stack. This happens before the recursive call is made.
    - The next time the code runs with old frame object is after `factorial(n-1)` has returned. When `factorial(5)` is called `factorial(n-1)`  will be `factorial(4)` which returns 24.
    - This is when the second half of the line runs. The return number now looks like 5*24 — which is how the whole function returns 120.
- The recursive implementation for calculating factorials has a critical weakness. If you want to calculated the factorial of 1,001, you program will have to make 1,001 recursive calls and create 1,001 frame objects. Your program is likely to cause a stack overflow before it can finish.
- The stack overflow can be avoided using a technique available in some programming languages called *tail call optimization*.

### Calculating a Fibonacci Sequence

- Fibonnacci sequence if a very classic example for introducing recursion. It’s a series of numbers that start with 1 and 1, and then the next value is the sum of the previous two values.

```jsx
//Iterative function
function fibonacci(n) {
    let seq = [1, 1]
    for (let i = 2; i < n; i++){
        seq.push(seq[i-2] + seq[i-1])
    }
    return seq[n-1]
}

console.log(fibonacci(10))
//returns 55
```

```jsx
//Recursive function
function fibonacci(n) {
    if (n === 1 | n === 2) return 1
    return fibonacci(n-1) + fibonacci(n-2)
}

console.log(fibonacci(10))
//returns 55
```

- The fibonacci algorithm also suffers from the call stack weakness. While the iterative `fibonacci(100)` call would take a second, the recursive algorithm would take over a million years to complete.

### Converting a Recursive Algorithm into an Iterative Algorithm

- Converting a recursive algo to iterative is always possible. Recursive function repeat a calculation by calling themselves, but this repetition can be performed instead by a loop. Recursive functions also make use of the call stack, however, an iterative algo can replace this witha. stack data structure. Thus any recursive algo can be performed iteratively using a loop and stack.z