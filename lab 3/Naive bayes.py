# Small dataset: [Outlook, Windy], and label
data = [
    {'Outlook': 'Sunny', 'Windy': False, 'Play': 'No'},
    {'Outlook': 'Sunny', 'Windy': True, 'Play': 'No'},
    {'Outlook': 'Overcast', 'Windy': False, 'Play': 'Yes'},
    {'Outlook': 'Rain', 'Windy': False, 'Play': 'Yes'},
    {'Outlook': 'Rain', 'Windy': True, 'Play': 'No'},
    {'Outlook': 'Overcast', 'Windy': True, 'Play': 'Yes'},
]

from collections import defaultdict

# Count how many times each class occurs
label_counts = defaultdict(int)
feature_counts = {
    'Yes': defaultdict(lambda: defaultdict(int)),
    'No': defaultdict(lambda: defaultdict(int))
}

# Train the model
for row in data:
    label = row['Play']
    label_counts[label] += 1
    for feature in ['Outlook', 'Windy']:
        value = row[feature]
        feature_counts[label][feature][value] += 1

# Predict function
def predict(example):
    total = sum(label_counts.values())
    scores = {}

    for label in label_counts:
        prob = label_counts[label] / total
        for feature in ['Outlook', 'Windy']:
            value = example[feature]
            count = feature_counts[label][feature].get(value, 0)
            total_feat = sum(feature_counts[label][feature].values())
            prob *= (count + 1) / (total_feat + 1)  # Laplace smoothing
        scores[label] = prob

    return "Yes, you can play!" if scores['Yes'] > scores['No'] else "No, you can't play!"

# Test it
test_case = {'Outlook': 'Sunny', 'Windy': False}
print(predict(test_case))
