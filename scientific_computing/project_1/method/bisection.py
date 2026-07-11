def bisection_method(a , b, step1, f, x): 

    bisection_method_answers = []
    reason = "Full Iteration of 10 steps" 
    if step1:
        for i in range(0, 10):
            xi = ((a + b) / 2).evalf(19)
            bisection_method_answers.append(xi)
            if i != 0:
                if abs(bisection_method_answers[i] - bisection_method_answers[i-1]) < 10**-9:
                    reason = "Stop Condition 2 occurred. | Xi+1 - Xi | < ε "
                    break
            if f.subs(x, a) * f.subs(x, xi) > 0:
                a = xi
            else:
                b = xi
        bisection_method_answers.append(reason)

    else:

        xi = ((a + b) / 2).evalf(19)
        bisection_method_answers.append(xi)

        if f.subs(x, a) * f.subs(x, xi) > 0:
                    a = xi
        else:
                    b = xi

        xi = ((a + b) / 2).evalf(19)
        bisection_method_answers.append(xi)

        while abs((bisection_method_answers[-1] - bisection_method_answers[-2]) / bisection_method_answers[-1]) >= 10**-6:
            if f.subs(x, a) * f.subs(x, xi) > 0:
                    a = xi
            else:
                    b = xi
            xi = ((a + b) / 2).evalf(19)
            bisection_method_answers.append(xi)

    return bisection_method_answers