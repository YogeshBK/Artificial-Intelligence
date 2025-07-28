# A very simple perceptron for AND and OR gates

def step_function(x):
    return 1 if x >= 0 else 0

def train(inputs, outputs, learning_rate=0.1, epochs=10):
    w1, w2, b = 0.0, 0.0, 0.0  # initial weights and bias

    for _ in range(epochs):
        for i in range(len(inputs)):
            x1, x2 = inputs[i]
            target = outputs[i]

            # Calculate output
            total = x1 * w1 + x2 * w2 + b
            y = step_function(total)

            # Update weights and bias
            error = target - y
            w1 += learning_rate * error * x1
            w2 += learning_rate * error * x2
            b += learning_rate * error

    return w1, w2, b

def test_gate(w1, w2, b, gate_name):
    print(f"\n{gate_name} Gate Results:")
    for x1 in [0, 1]:
        for x2 in [0, 1]:
            total = x1 * w1 + x2 * w2 + b
            output = step_function(total)
            print(f"{gate_name}({x1}, {x2}) = {output}")

# Inputs for both gates
inputs = [
    [0, 0],
    [0, 1],
    [1, 0],
    [1, 1]
]

# AND gate
and_outputs = [0, 0, 0, 1]
w1, w2, b = train(inputs, and_outputs)
test_gate(w1, w2, b, "AND")

# OR gate
or_outputs = [0, 1, 1, 1]
w1, w2, b = train(inputs, or_outputs)
test_gate(w1, w2, b, "OR")
