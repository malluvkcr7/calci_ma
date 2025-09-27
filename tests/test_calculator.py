import math
import pytest
import sys
import os

# Add the parent directory to the Python path so we can import calculator
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from calculator import sqrt, factorial, ln, power

def test_sqrt():
    assert sqrt(9) == 3
    assert sqrt(2) == pytest.approx(math.sqrt(2), rel=1e-9)

def test_sqrt_negative():
    with pytest.raises(ValueError):
        sqrt(-1)

def test_factorial():
    assert factorial(0) == 1
    assert factorial(5) == 120

def test_factorial_nonint():
    with pytest.raises(ValueError):
        factorial(3.4)

def test_ln():
    assert ln(math.e) == pytest.approx(1.0, rel=1e-9)
    with pytest.raises(ValueError):
        ln(0)

def test_power():
    assert power(2, 3) == 8
    assert power(9, 0.5) == pytest.approx(3, rel=1e-9)