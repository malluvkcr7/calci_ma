#!/usr/bin/env python3
# calculator.py - core functions + simple CLI

import math
import sys

def sqrt(x):
    if x < 0:
        raise ValueError("sqrt domain error: x must be >= 0")
    return math.sqrt(x)

def factorial(x):
    if not float(x).is_integer():
        raise ValueError("factorial requires an integer")
    n = int(x)
    if n < 0:
        raise ValueError("factorial domain error: n must be >= 0")
    return math.factorial(n)

def ln(x):
    if x <= 0:
        raise ValueError("ln domain error: x must be > 0")
    return math.log(x)

def power(x, b):
    return float(x) ** float(b)

def interactive_menu():
    menu = """
Scientific Calculator - choose an option:
1) sqrt(x)
2) factorial(x)
3) ln(x)
4) x^b
5) exit
Enter choice: """
    while True:
        choice = input(menu).strip()
        if choice == '1':
            x = float(input("Enter x: "))
            print("=>", sqrt(x))
        elif choice == '2':
            x = float(input("Enter non-negative integer x: "))
            print("=>", factorial(x))
        elif choice == '3':
            x = float(input("Enter x (>0): "))
            print("=>", ln(x))
        elif choice == '4':
            x = float(input("Enter x: "))
            b = float(input("Enter b: "))
            print("=>", power(x, b))
        elif choice == '5' or choice.lower() == 'exit':
            print("Goodbye.")
            break
        else:
            print("Invalid choice.")

def main():
    # Allow either CLI args or interactive menu
    if len(sys.argv) > 1:
        # Examples: python calculator.py sqrt 9
        op = sys.argv[1].lower()
        try:
            if op in ('sqrt', 'sqrtx'):
                print(sqrt(float(sys.argv[2])))
            elif op in ('fact', 'factorial'):
                print(factorial(float(sys.argv[2])))
            elif op in ('ln', 'log'):
                print(ln(float(sys.argv[2])))
            elif op in ('pow', 'power'):
                print(power(float(sys.argv[2]), float(sys.argv[3])))
            else:
                print("Unknown op.")
        except Exception as e:
            print("Error:", e)
    else:
        interactive_menu()

if __name__ == '__main__':
    main()
