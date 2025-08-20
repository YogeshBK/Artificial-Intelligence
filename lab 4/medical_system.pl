% Medical Expert System


:- dynamic has_symptom/2.

% Rule 1: Fever related conditions
has_condition(Patient, flu) :-
    has_symptom(Patient, fever),
    has_symptom(Patient, cough),
    has_symptom(Patient, body_aches),
    has_symptom(Patient, fatigue).

has_condition(Patient, common_cold) :-
    has_symptom(Patient, runny_nose),
    has_symptom(Patient, sneezing),
    has_symptom(Patient, sore_throat),
    not(has_symptom(Patient, high_fever)).

has_condition(Patient, covid19) :-
    has_symptom(Patient, fever),
    has_symptom(Patient, dry_cough),
    has_symptom(Patient, shortness_of_breath),
    has_symptom(Patient, loss_of_taste_or_smell).

% Rule 2: Digestive issues
has_condition(Patient, food_poisoning) :-
    has_symptom(Patient, nausea),
    has_symptom(Patient, vomiting),
    has_symptom(Patient, diarrhea),
    has_symptom(Patient, stomach_pain).

has_condition(Patient, acid_reflux) :-
    has_symptom(Patient, heartburn),
    has_symptom(Patient, regurgitation),
    has_symptom(Patient, bloating).

% Rule 3: Head-related conditions
has_condition(Patient, migraine) :-
    has_symptom(Patient, severe_headache),
    has_symptom(Patient, sensitivity_to_light),
    has_symptom(Patient, nausea).

has_condition(Patient, tension_headache) :-
    has_symptom(Patient, mild_to_moderate_headache),
    has_symptom(Patient, pressure_around_forehead).

% Emergency conditions
emergency_condition(Patient, heart_attack) :-
    has_symptom(Patient, chest_pain),
    has_symptom(Patient, shortness_of_breath),
    has_symptom(Patient, nausea),
    has_symptom(Patient, cold_sweat).

emergency_condition(Patient, stroke) :-
    (has_symptom(Patient, face_drooping);
    (has_symptom(Patient, arm_weakness);
    (has_symptom(Patient, speech_difficulty)).

% Recommendations
recommendation(flu, 'Rest, drink fluids, take fever reducers like acetaminophen.').
recommendation(common_cold, 'Rest, stay hydrated, use over-the-counter cold medicine.').
recommendation(covid19, 'Self-isolate, get tested, monitor symptoms, seek emergency care if breathing difficulties.').
recommendation(food_poisoning, 'Stay hydrated, eat bland foods, rest, see doctor if symptoms persist.').
recommendation(acid_reflux, 'Avoid spicy/fatty foods, eat smaller meals, antacids may help.').
recommendation(migraine, 'Rest in dark room, take pain relievers, avoid triggers like stress.').
recommendation(tension_headache, 'Use over-the-counter pain relievers, practice stress reduction techniques.').

% Consultation interface
diagnose(Patient) :-
    emergency_condition(Patient, Condition),
    !,
    nl, write('EMERGENCY! '), write(Patient), write(' may be having: '), write(Condition), nl,
    write('Seek immediate medical attention! Call emergency services.'), nl, nl.

diagnose(Patient) :-
    has_condition(Patient, Condition),
    recommendation(Condition, Advice),
    nl, write('Diagnosis for '), write(Patient), write(': '), write(Condition), nl,
    write('Recommendation: '), write(Advice), nl, nl.

diagnose(Patient) :-
    nl, write('Unable to determine condition for '), write(Patient), write(' based on symptoms.'), nl,
    write('If symptoms persist or worsen, consult a healthcare professional.'), nl, nl.

% Helper predicate to ask questions
ask_symptom(Patient, Symptom) :-
    write('Does '), write(Patient), write(' have '), write(Symptom), write('? (yes/no): '),
    read(Response),
    (Response == yes -> assertz(has_symptom(Patient, Symptom)); true).

% Main menu system
main_menu :-
    nl, nl,
    write('=== Medical Expert System ==='), nl,
    write('1. Start new diagnosis'), nl,
    write('2. View all conditions'), nl,
    write('3. Exit'), nl, nl,
    write('Select option (1-3): '),
    read(Choice),
    process_choice(Choice).

process_choice(1) :-
    start_consultation,
    main_menu.

process_choice(2) :-
    list_conditions,
    main_menu.

process_choice(3) :-
    write('Exiting system. Goodbye!'), nl.

process_choice(_) :-
    write('Invalid choice. Please try again.'), nl,
    main_menu.

% List all known conditions
list_conditions :-
    nl,
    write('=== Known Conditions ==='), nl, nl,
    write('1. Flu'), nl,
    write('2. Common Cold'), nl,
    write('3. COVID-19'), nl,
    write('4. Food Poisoning'), nl,
    write('5. Acid Reflux'), nl,
    write('6. Migraine'), nl,
    write('7. Tension Headache'), nl,
    write('8. Heart Attack (Emergency)'), nl,
    write('9. Stroke (Emergency)'), nl, nl.

% Sample consultation
start_consultation :-
    nl,
    write('=== New Diagnosis ==='), nl, nl,
    write('Please enter patient name: '),
    read(Patient),
    retractall(has_symptom(Patient, _)),
    
    % Ask about symptoms
    ask_symptom(Patient, fever),
    ask_symptom(Patient, cough),
    ask_symptom(Patient, body_aches),
    ask_symptom(Patient, fatigue),
    ask_symptom(Patient, runny_nose),
    ask_symptom(Patient, sneezing),
    ask_symptom(Patient, sore_throat),
    ask_symptom(Patient, dry_cough),
    ask_symptom(Patient, shortness_of_breath),
    ask_symptom(Patient, loss_of_taste_or_smell),
    ask_symptom(Patient, high_fever),
    ask_symptom(Patient, nausea),
    ask_symptom(Patient, vomiting),
    ask_symptom(Patient, diarrhea),
    ask_symptom(Patient, stomach_pain),
    ask_symptom(Patient, heartburn),
    ask_symptom(Patient, regurgitation),
    ask_symptom(Patient, bloating),
    ask_symptom(Patient, severe_headache),
    ask_symptom(Patient, sensitivity_to_light),
    ask_symptom(Patient, mild_to_moderate_headache),
    ask_symptom(Patient, pressure_around_forehead),
    ask_symptom(Patient, chest_pain),
    ask_symptom(Patient, cold_sweat),
    ask_symptom(Patient, face_drooping),
    ask_symptom(Patient, arm_weakness),
    ask_symptom(Patient, speech_difficulty),
    
    % Perform diagnosis
    diagnose(Patient).

:- initialization(main_menu).