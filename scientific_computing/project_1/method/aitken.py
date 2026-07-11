def aitkenـmethod(Sequence):
    aitkenـmethod_answers = []
    if len(Sequence) < 3:
        return "Len of Sequence is lower than 3. Can not user Aitken method on this Sequence"
        
    for i in range(len(Sequence) - 2):
        if Sequence[i+2] + Sequence[i] - 2*Sequence[i+1] == 0:
            break
        xi = (Sequence[i] - ((Sequence[i+1] - Sequence[i])**2) / Sequence[i+2] + Sequence[i] - 2*Sequence[i+1]).evalf(19)
        aitkenـmethod_answers.append(xi)
    return aitkenـmethod_answers