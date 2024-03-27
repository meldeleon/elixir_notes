function power (base, n, acc){
return (n === 0) ? acc : power(base, n-1, base * acc)
}

console.log(power(2, 6, 1))