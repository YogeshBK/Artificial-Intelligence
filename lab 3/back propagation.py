import math
import random

def sigmoid(z):
    return 1 / (1 + math.exp(-z))

def sigmoid_deriv(y):
    return y * (1 - y)

def forward(x1, x2, w1, w2, b):
    z = x1 * w1[0] + x2 * w1[1] + b[0]
    h1 = sigmoid(z)
    z = x1 * w2[0] + x2 * w2[1] + b[1]
    h2 = sigmoid(z)

    z = h1 * w_out[0] + h2 * w_out[1] + b[2]
    y = sigmoid(z)
    return h1, h2, y

x_data = [[0,0], [0,1], [1,0], [1,1]]
t_data = [0, 1, 1, 0]

w1 = [random.random(), random.random()]
w2 = [random.random(), random.random()]
w_out = [random.random(), random.random()]
b = [random.random(), random.random(), random.random()]

lr = 0.5

for _ in range(10000):
    for i in range(4):
        x1, x2 = x_data[i]
        t = t_data[i]

        h1_input = x1 * w1[0] + x2 * w1[1] + b[0]
        h1 = sigmoid(h1_input)

        h2_input = x1 * w2[0] + x2 * w2[1] + b[1]
        h2 = sigmoid(h2_input)

        z = h1 * w_out[0] + h2 * w_out[1] + b[2]
        y = sigmoid(z)

        error = t - y
        dy = error * sigmoid_deriv(y)

        dw_out0 = dy * h1
        dw_out1 = dy * h2

        dh1 = dy * w_out[0] * sigmoid_deriv(h1)
        dh2 = dy * w_out[1] * sigmoid_deriv(h2)

        w_out[0] += lr * dw_out0
        w_out[1] += lr * dw_out1
        b[2] += lr * dy

        w1[0] += lr * dh1 * x1
        w1[1] += lr * dh1 * x2
        b[0] += lr * dh1

        w2[0] += lr * dh2 * x1
        w2[1] += lr * dh2 * x2
        b[1] += lr * dh2

for x1, x2 in x_data:
    h1, h2, y = forward(x1, x2, w1, w2, b)
    print(f"{x1} {x2} -> {round(y)}")
