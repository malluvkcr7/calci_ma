#!/usr/bin/env python3
# web_calculator.py - Flask web interface for the calculator

from flask import Flask, render_template, request, jsonify
import sys
import os

# Add the current directory to Python path to import calculator
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
from calculator import sqrt, factorial, ln, power

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/calculate', methods=['POST'])
def calculate():
    try:
        data = request.get_json()
        operation = data['operation']
        
        if operation == 'sqrt':
            x = float(data['x'])
            result = sqrt(x)
        elif operation == 'factorial':
            x = float(data['x'])
            result = factorial(x)
        elif operation == 'ln':
            x = float(data['x'])
            result = ln(x)
        elif operation == 'power':
            x = float(data['x'])
            b = float(data['b'])
            result = power(x, b)
        else:
            return jsonify({'error': 'Unknown operation'}), 400
            
        return jsonify({'result': result})
    
    except ValueError as e:
        return jsonify({'error': str(e)}), 400
    except Exception as e:
        return jsonify({'error': f'Calculation error: {str(e)}'}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)