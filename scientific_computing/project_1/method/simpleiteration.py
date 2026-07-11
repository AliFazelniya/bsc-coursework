from sympy import sympify, diff

def check_gx (x, f, a, b):
    g1 = x + f
    g2 = x - f
    g3 = sympify(input("Enter your first g(x) equation suggestion: "))
    g4 = sympify(input("Enter your second g(x) equation suggestion: "))
    g5 = sympify(input("Enter your third g(x) equation suggestion: "))
    g_list = [g1, g2, g3, g4, g5]
    valid_g_list = []

    for i, g in enumerate(g_list):
        in_range = all((gx := g.subs(x, xi)).is_real and a <= gx.evalf() <= b for xi in [a, b])
        g_prime = diff(g, x)
        check_points = [a, b, (a + b) / 2]
        derivative_check = all(abs(g_prime.subs(x, xi).evalf()) < 1 for xi in check_points)

        if in_range and derivative_check:
            valid_g_list.append(g)
    
    return valid_g_list

def simpleـiteration(x0, step1, x, f, a, b):
    gx = check_gx(x, f, a, b)

    while len(gx) == 0:
        print("Invalid g(x)s, please enter again.")
        gx = check_gx(x, f, a, b)

    all_simpleـiteration_answers_per_gx = []

    if step1:
        for gfunction in gx:
                
            gx_function = gfunction
            simpleـiteration_answers = []
            simpleـiteration_answers.append(x0)
            
            for i in range(1, 11):
                xi = gx_function.subs(x, simpleـiteration_answers[i-1])
                simpleـiteration_answers.append(xi)
                if abs(simpleـiteration_answers[i] - simpleـiteration_answers[i-1]) < 10**-9:
                    break

            all_simpleـiteration_answers_per_gx.append((simpleـiteration_answers , len(simpleـiteration_answers)))    
    else:
        for gfunction in gx:
                
            gx_function = gfunction
            simpleـiteration_answers = []
            simpleـiteration_answers.append(x0)

            xi = gx_function.subs(x, simpleـiteration_answers[-1])
            simpleـiteration_answers.append(xi)

            while abs((simpleـiteration_answers[-1] - simpleـiteration_answers[-2]) / simpleـiteration_answers[-1]) >= 10**-6:
                xi = gx_function.subs(x, simpleـiteration_answers[-1])
                simpleـiteration_answers.append(xi)

            all_simpleـiteration_answers_per_gx.append((simpleـiteration_answers , len(simpleـiteration_answers)))    

    sorted_all_simpleـiteration_answers_per_gx = sorted(all_simpleـiteration_answers_per_gx, key=lambda x: x[1])
    
    print(f"Best g(x): {gx[all_simpleـiteration_answers_per_gx.index(sorted_all_simpleـiteration_answers_per_gx[0])]}")
    return sorted_all_simpleـiteration_answers_per_gx[0][0]