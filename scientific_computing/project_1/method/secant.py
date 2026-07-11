def check_zero_devision(x0, x1, f, x):
    if f.subs(x, x1) - f.subs(x, x0) == 0:
        return True
    
def secant_method(x0, x1, step1, f, x):

    secant_method_answers = []
    reason = "Full Iteration of 10 steps" 
    if step1:
        for i in range(10):
            if check_zero_devision(x0, x1, f, x) == True:
                print("Error: Division by zero in Secant Method.")
                break
            xi = (x0 - ((x1 - x0) / (f.subs(x, x1) - f.subs(x, x0))) * f.subs(x, x0)).evalf(19)
            secant_method_answers.append(xi) 
            if i != 0:
                if abs(secant_method_answers[i] - secant_method_answers[i-1]) < 10**-9:
                    reason = "Stop Condition 2 occurred. | Xi+1 - Xi | < ε "
                    break

            if f.subs(x, x0) * f.subs(x, xi) > 0:
                x0 = xi
            else:
                x1 = xi

        secant_method_answers.append(reason)
    
    else:
        for i in range(2):
            if check_zero_devision(x0, x1, f, x) == True:
                print("Error: Division by zero in Secant Method.")
                break
            
            xi = (x0 - ((x1 - x0) / (f.subs(x, x1) - f.subs(x, x0))) * f.subs(x, x0)).evalf(19)
            secant_method_answers.append(xi)

            if f.subs(x, x0) * f.subs(x, xi) > 0:
                    x0 = xi
            else:
                    x1 = xi

        while abs((secant_method_answers[-1] - secant_method_answers[-2]) / secant_method_answers[-1]) >= 10**-6:
            if check_zero_devision(x0, x1, f, x) == True:
                print("Error: Division by zero in Secant Method.")
                break

            xi = (x0 - ((x1 - x0) / (f.subs(x, x1) - f.subs(x, x0))) * f.subs(x, x0)).evalf(19)
            secant_method_answers.append(xi)
            if f.subs(x, x0) * f.subs(x, xi) > 0:
                x0 = xi
            else:
                x1 = xi

    return secant_method_answers