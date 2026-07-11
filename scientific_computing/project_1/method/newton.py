from sympy import diff

def newton_method(a, b, f, step1, x):

    newton_method_answers = []
    newton_method_answers.append(((a+b) / 2).evalf(19))
    f_diff = diff(f, x)
    reason = "Full Iteration of 10 steps" 
    if step1:
        for i in range(10):
            xi = (newton_method_answers[i] - f.subs(x, newton_method_answers[i]) / f_diff.subs(x, newton_method_answers[i])).evalf(19)
            if i != 0:
                if abs(newton_method_answers[i] - newton_method_answers[i-1]) < 10**-9:
                    reason = "Stop Condition 2 occurred. | Xi+1 - Xi | < ε "
                    break
            newton_method_answers.append(xi)

        newton_method_answers.append(reason)
    else:
        xi = newton_method_answers[-1] - f.subs(x, newton_method_answers[-1]) / f_diff.subs(x, newton_method_answers[-1]).evalf(19)
        newton_method_answers.append(xi)

        while abs((newton_method_answers[-1] - newton_method_answers[-2]) / newton_method_answers[-1]) >= 10**-6:
            xi = newton_method_answers[-1] - f.subs(x, newton_method_answers[-1]) / f_diff.subs(x, newton_method_answers[-1]).evalf(19)
            newton_method_answers.append(xi)
  
    return newton_method_answers