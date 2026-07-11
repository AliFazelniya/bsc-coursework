import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd

def user_choice_two(bisection_method_answers_step2, newton_method_answers_step2, secant_method_answers_based_on_a_b_step2, secant_method_answers_based_on_bisection_method_answers_step2, secant_method_answers_based_on_newton_method_answers_step2, simpleـiteration_answers_step2, aitkenـmethod_answers_based_on_bisection_method_answers_step2, aitkenـmethod_answers_based_on_newton_method_answers_step2, aitkenـmethod_answers_based_on_secant_method_answers_based_on_a_b_step2, aitkenـmethod_answers_based_on_secant_method_answers_based_on_bisection_method_answers_step2, aitkenـmethod_answers_based_on_secant_method_answers_based_on_newton_method_answers_step2, aitkenـmethod_answers_based_on_simpleـiteration_answers_step2, root):
        print("Welcome to the analyze part 2. In this part all step 2 details of the function you entered will be shown.")
        print("now here is the details of the function you entered in step 2:")
        print("\n")
        print("Final answers of methods:")
        print(f"Bisection Method finall answer: {bisection_method_answers_step2[-1]}")
        print(f"Newton Method finall answer: {newton_method_answers_step2[-1]}")
        print(f"Secant Method based on a and b final answer: {secant_method_answers_based_on_a_b_step2[-1]}")
        print(f"Secant Method based on bisection method finall answer: {secant_method_answers_based_on_bisection_method_answers_step2[-1]}")
        print(f"Secant Method based on Newton Method final answer: {secant_method_answers_based_on_newton_method_answers_step2[-1]}")
        print(f"Simple Iteration final answer: {simpleـiteration_answers_step2[-1]}")

        user_plot_choice = input("Do you want to check this as a plot (y/n)? ")

        if user_plot_choice == "y":
            method_names = ["BM", "NM", "SM_a_b", "SM_BM", "SM_NM", "SIM"]
            finall_answers = [bisection_method_answers_step2[-2], newton_method_answers_step2[-2], secant_method_answers_based_on_a_b_step2[-2], secant_method_answers_based_on_bisection_method_answers_step2[-2], secant_method_answers_based_on_newton_method_answers_step2[-2], simpleـiteration_answers_step2[-2]]
            float_finall_answers = [float(x.evalf()) for x in finall_answers]
            df = pd.DataFrame({"Finall Answers": float_finall_answers, "Method Names": method_names})
            plt.figure(figsize=(10, 6))
            sns.pointplot(data=df, x="Method Names", y="Finall Answers", join=True, capsize=0.1)
            plt.title("Methods Finall Answers")
            # plt.xticks(rotation=90)
            plt.grid(axis='x')
            plt.tight_layout()
            plt.show()
            plt.figure(figsize=(10, 6))
        else:
            print("Alright! Lets continue.")

        print("================================================================================")
        print("Difference between methods:")
        differences_list = [
            ("Difference between bisection method and Newton Method", abs(bisection_method_answers_step2[-1] - newton_method_answers_step2[-1])),
            ("Difference between bisection method and Secant Method based on a and b", abs(bisection_method_answers_step2[-1] - secant_method_answers_based_on_a_b_step2[-1])),
            ("Difference between bisection method and Secant Method based on bisection method answers", abs(bisection_method_answers_step2[-1] - secant_method_answers_based_on_bisection_method_answers_step2[-1])),
            ("Difference between bisection method and Secant Method based on Newton Method answers", abs(bisection_method_answers_step2[-1] - secant_method_answers_based_on_newton_method_answers_step2[-1])),
            ("Difference between bisection method and Simple Iteration", abs(bisection_method_answers_step2[-1] - simpleـiteration_answers_step2[-1])),
            ("Difference between Newton Method and Secant Method based on a and b" , abs(newton_method_answers_step2[-1] - secant_method_answers_based_on_a_b_step2[-1])), 
            ("Difference between Newton Method and Secant Method based on bisection method answers" , abs(newton_method_answers_step2[-1] - secant_method_answers_based_on_bisection_method_answers_step2[-1])),
            ("Difference between Newton Method and Secant Method based on Newton Method answers", abs(newton_method_answers_step2[-1] - secant_method_answers_based_on_newton_method_answers_step2[-1])),
            ("Difference between Newton Method and Simple Iteration", abs(newton_method_answers_step2[-1] - simpleـiteration_answers_step2[-1])),
            ("Difference between Secant Method based on a and b and Secant Method based on bisection method answers", abs(secant_method_answers_based_on_a_b_step2[-1] - secant_method_answers_based_on_bisection_method_answers_step2[-1])),
            ("Difference between Secant Method based on a and b and Secant Method based on Newton Method answers", abs(secant_method_answers_based_on_a_b_step2[-1] - secant_method_answers_based_on_newton_method_answers_step2[-1])),
            ("Difference between Secant Method based on a and b and Simple Iteration", abs(secant_method_answers_based_on_a_b_step2[-1] - simpleـiteration_answers_step2[-1])),
            ("Difference between Secant Method based on bisection method answers and Secant Method based on Newton Method answers",  abs(secant_method_answers_based_on_bisection_method_answers_step2[-1] - secant_method_answers_based_on_newton_method_answers_step2[-1])),
            ("Difference between Secant Method based on bisection method answers and Simple Iteration" , abs(secant_method_answers_based_on_bisection_method_answers_step2[-1] - simpleـiteration_answers_step2[-1])),
            ("Difference between Secant Method based on Newton Method answers and Simple Iteration" , abs(secant_method_answers_based_on_newton_method_answers_step2[-1] - simpleـiteration_answers_step2[-1]))]

        for i, (description, value) in enumerate(differences_list):
            print(f"{description} : {value}")
            if i in [4, 8, 11, 13]:
                print("--------------------------------")

        sorted_differences_list = sorted(differences_list, key=lambda x: x[1])

        print("--------------------------------")
        print(f"The lowest error is for : {sorted_differences_list[0][0]}")
        print(f"The highst error is for : {sorted_differences_list[-1][0]}")

        user_plot_choice = input("Do you want to check this as a plot (y/n)? ")

        if user_plot_choice == "y":
            descriptions = ["BM - NM", "BM - SM1", "BM - SM2", "BM - SM3", "BM - SIM", "NM - SM1", "NM - SM2", "NM - SM3", "NM - SIM", "SM1 - SM2", "SM1 - SM3", "SM1 - SIM", "SM2 - SM3", "SM2 - SIM", "SM3 - SIM"]
            values = [float(item[1].evalf(19)) for item in differences_list]
            df = pd.DataFrame({"Difference": values, "Method Comparison": descriptions})
            plt.figure(figsize=(10, 6))
            sns.pointplot(data=df, x="Method Comparison", y="Difference", join=True, capsize=0.1)
            plt.title("Methods Differences")
            plt.xticks(rotation=90)
            plt.grid(axis='x')
            plt.yscale('log')
            plt.tight_layout()
            plt.show()

            plt.figure(figsize=(10, 6))
            plt.bar(descriptions, values, color='red')
            plt.title("Methods Differences", fontsize=14)
            plt.xlabel("Methods", fontsize=12)
            plt.ylabel("Difference", fontsize=12)
            plt.xticks(rotation=90, fontsize=10)
            plt.tight_layout()
            plt.yscale('log')
            plt.grid(axis='y', linestyle='--', alpha=0.7)
            plt.show()
        else:
            print("Alright! Lets continue.")

        print("--------------------------------")
        if root != False:
            print("Errors of methods: (Difference between each final method answer with the root)")
            print(f"Bisection Method finall answer error: {abs(root - bisection_method_answers_step2[-1])}")
            print(f"Newton Method finall answer error: {abs(root - newton_method_answers_step2[-1])}")
            print(f"Secant Method based on a and b final answer error: {abs(root - secant_method_answers_based_on_a_b_step2[-1])}")
            print(f"Secant Method based on bisection method finall answer error: {abs(root - secant_method_answers_based_on_bisection_method_answers_step2[-1])}")
            print(f"Secant Method based on Newton Method final answer error: {abs(root - secant_method_answers_based_on_newton_method_answers_step2[-1])}")
            print(f"Simple Iteration final answer error: {abs(root - simpleـiteration_answers_step2[-1])}")
            
            user_plot_choice = input("Do you want to check this as a plot (y/n)? ")
            if user_plot_choice == "y":
                method_names = ["BM", "NM", "SM_a_b", "SM_BM", "SM_NM", "SIM"]
                method_errors = [abs(root - bisection_method_answers_step2[-2]), abs(root - newton_method_answers_step2[-2]), abs(root - secant_method_answers_based_on_a_b_step2[-2]), abs(root - secant_method_answers_based_on_bisection_method_answers_step2[-2]), abs(root - secant_method_answers_based_on_newton_method_answers_step2[-2]),abs(root - simpleـiteration_answers_step2[-2]) ]
                df = pd.DataFrame({"Errors": method_errors, "Method Names": method_names})
                plt.figure(figsize=(10, 6))
                sns.pointplot(data=df, x="Method Names", y="Errors", join=True, capsize=0.1)
                plt.title("Methods Root Errors")
                # plt.xticks(rotation=90)
                plt.grid(axis='x')
                plt.yscale('log')
                plt.tight_layout()
                plt.show()

                plt.figure(figsize=(10, 6))
                plt.bar(method_names, method_errors, color='red')
                plt.title("Methods Root Errors", fontsize=14)
                plt.xlabel("Methods Name", fontsize=12)
                plt.ylabel("Errors", fontsize=12)
                plt.xticks(fontsize=10)
                plt.tight_layout()
                plt.yscale('log')
                plt.grid(axis='y', linestyle='--', alpha=0.7)
                plt.show()
            else:
                print("Alright! Lets continue.")

            print("================================================================================")

        print("Length of methods:")
        print(f"bisection_method_answers: {len(bisection_method_answers_step2)}")
        print(f"Newton Method answers: {len(newton_method_answers_step2)}")
        print(f"Secant Method answers based on a and b: {len(secant_method_answers_based_on_a_b_step2)}")
        print(f"Secant Method answers based on bisection method answers: {len(secant_method_answers_based_on_bisection_method_answers_step2)}")
        print(f"Secant Method answers based on Newton Method answers: {len(secant_method_answers_based_on_newton_method_answers_step2)}")
        print(f"Simple Iteration answers: {len(simpleـiteration_answers_step2)}")


        length_of_methods = [('bisection_method_answers', len(bisection_method_answers_step2)), 
        ('newton_method_answers', len(newton_method_answers_step2)), 
        ('secant_method_answers_based_on_a_b', len(secant_method_answers_based_on_a_b_step2)), 
        ('secant_method_answers_based_on_bisection_method_answers',len(secant_method_answers_based_on_bisection_method_answers_step2)),
        ('secant_method_answers_based_on_newton_method_answers',len(secant_method_answers_based_on_newton_method_answers_step2)),
        ('simpleـiteration_answers', len(simpleـiteration_answers_step2))]

        # Filter out tuples with zero length
        length_of_methods = [tup for tup in length_of_methods if tup[1] > 0]
        sorted_length_of_methods = sorted(length_of_methods, key=lambda x: x[1])
        fastest_method_step2 = sorted_length_of_methods[0]
        print(f"Fastest Method: {fastest_method_step2}")

        user_plot_choice = input("Do you want to check this as a plot (y/n)? ")

        if user_plot_choice == "y":
            method_names = ["BM", "NM", "SM_a_b", "SM_BM", "SM_NM", "SIM"]
            method_lengths = [tup[1] for tup in sorted_length_of_methods]
            df = pd.DataFrame({"lengths": method_lengths, "method_names": method_names})
            plt.figure(figsize=(10, 6))
            sns.pointplot(data=df, x="method_names", y="lengths", join=True, capsize=0.1)
            plt.title("Methods Differences")
            plt.grid(axis='x')
            plt.tight_layout()
            plt.show()

            plt.figure(figsize=(10, 6))
            plt.bar(method_names, method_lengths, color='red')
            plt.title("Lenghts of methods", fontsize=14)
            plt.xlabel("Methods", fontsize=12)
            plt.ylabel("length", fontsize=12)
            plt.xticks(rotation=90, fontsize=10)
            plt.tight_layout()
            plt.grid(axis='y', linestyle='--', alpha=0.7)
            plt.show()
        else:
            print("Alright! Lets continue.")

        print("================================================================================")
        print("Aitken Method Part.")
        print("Final answers of methods:")
        aitkenـmethod_based_on_bisection_method_finall_answer = aitkenـmethod_answers_based_on_bisection_method_answers_step2[-1] if len(aitkenـmethod_answers_based_on_bisection_method_answers_step2) > 0 else None
        aitkenـmethod_based_on_newton_method_finall_answer = aitkenـmethod_answers_based_on_newton_method_answers_step2[-1] if len(aitkenـmethod_answers_based_on_newton_method_answers_step2) > 0 else None
        aitkenـmethod_based_on_secant_method_answers_based_on_a_b = aitkenـmethod_answers_based_on_secant_method_answers_based_on_a_b_step2[-1] if len(aitkenـmethod_answers_based_on_secant_method_answers_based_on_a_b_step2) > 0 else None
        aitkenـmethod_based_on_secant_method_based_on_bisection_method_finall_answer = aitkenـmethod_answers_based_on_secant_method_answers_based_on_bisection_method_answers_step2[-1] if len(aitkenـmethod_answers_based_on_secant_method_answers_based_on_bisection_method_answers_step2) > 0 else None
        aitkenـmethod_based_on_secant_method_based_on_newton_method_finall_answer = aitkenـmethod_answers_based_on_secant_method_answers_based_on_newton_method_answers_step2[-1] if len(aitkenـmethod_answers_based_on_secant_method_answers_based_on_newton_method_answers_step2) > 0 else None
        aitkenـmethod_based_on_simpleـiteration_finall_answer = aitkenـmethod_answers_based_on_simpleـiteration_answers_step2[-1] if len(aitkenـmethod_answers_based_on_simpleـiteration_answers_step2) > 0 else None

        print(f"Aitken Method based on bisection method final answer: {aitkenـmethod_based_on_bisection_method_finall_answer}")
        print(f"Aitken Method based on Newton Method final answer: {aitkenـmethod_based_on_newton_method_finall_answer}")
        print(f"Aitken Method based on Secant Method answers based on a and b final answer: {aitkenـmethod_based_on_secant_method_answers_based_on_a_b}")
        print(f"Aitken Method based on Secant Method answers based on bisection method final answer: {aitkenـmethod_based_on_secant_method_based_on_bisection_method_finall_answer}")
        print(f"Aitken Method based on Secant Method answers based on Newton Method final answer: {aitkenـmethod_based_on_secant_method_based_on_newton_method_finall_answer}")
        print(f"Aitken Method based on Simple Iteration final answer: {aitkenـmethod_based_on_simpleـiteration_finall_answer}")
        print("================================================================================")
        if root != False:
            print("Errors of methods accelerated with Aitken Method: (Difference between each final method answer with the root)")
            print(f"Aitken Method based on bisection method final answer error: {(abs(root - aitkenـmethod_based_on_bisection_method_finall_answer)) if aitkenـmethod_based_on_bisection_method_finall_answer != None else "Invalid"}")
            print(f"Aitken Method based on Newton Method final answer error: {(abs(root - aitkenـmethod_based_on_newton_method_finall_answer)) if aitkenـmethod_based_on_newton_method_finall_answer != None else "Invalid"}")
            print(f"Aitken Method based on Secant Method based on a and b final answer error: {(abs(root - aitkenـmethod_based_on_secant_method_answers_based_on_a_b)) if aitkenـmethod_based_on_secant_method_answers_based_on_a_b != None else "Invalid"}")
            print(f"Aitken Method based on bisection method finall answer error: {(abs(root - aitkenـmethod_answers_based_on_secant_method_answers_based_on_bisection_method_answers_step2[-1])) if aitkenـmethod_answers_based_on_secant_method_answers_based_on_bisection_method_answers_step2 else "Invalid"}")
            print(f"Aitken Method based on Newton Method final answer error: {(abs(root - aitkenـmethod_based_on_secant_method_based_on_bisection_method_finall_answer)) if aitkenـmethod_based_on_secant_method_based_on_bisection_method_finall_answer != None else "Invalid"}")
            print(f"Aitken Method based on Simple Iteration answer error: {(abs(root - aitkenـmethod_based_on_simpleـiteration_finall_answer)) if aitkenـmethod_based_on_simpleـiteration_finall_answer != None else "Invalid"}")
            print("================================================================================")

        print("Length of methods:")
        print(f"Aitken Method answers based on bisection method answers: {len(aitkenـmethod_answers_based_on_bisection_method_answers_step2)}")
        print(f"Aitken Method answers based on Newton Method answers: {len(aitkenـmethod_answers_based_on_newton_method_answers_step2)}")
        print(f"Aitken Method answers based on Secant Method answers based on a b: {len(aitkenـmethod_answers_based_on_secant_method_answers_based_on_a_b_step2)}")
        print(f"Aitken Method answers based on Secant Method answers based on bisection method answers: {len(aitkenـmethod_answers_based_on_secant_method_answers_based_on_bisection_method_answers_step2)}")
        print(f"Aitken Method answers based on Secant Method answers based on Newton Method answers: {len(aitkenـmethod_answers_based_on_secant_method_answers_based_on_newton_method_answers_step2)}")
        print(f"Aitken Method answers based on Simple Iteration answers: {len(aitkenـmethod_answers_based_on_simpleـiteration_answers_step2)}")

        length_of_Aitken_methods = [('Aitken Method answers based on bisection method answers', len(aitkenـmethod_answers_based_on_bisection_method_answers_step2)), 
        ('Aitken Method answers based on Newton Method answers', len(aitkenـmethod_answers_based_on_newton_method_answers_step2)), 
        ('Aitken Method answers based on Secant Method answers based on a b', len(aitkenـmethod_answers_based_on_secant_method_answers_based_on_a_b_step2)), 
        ('Aitken Method answers based on Secant Method answers based on bisection method answers',len(aitkenـmethod_answers_based_on_secant_method_answers_based_on_bisection_method_answers_step2)),
        ('Aitken Method answers based on Secant Method answers based on Newton Method answers',len(aitkenـmethod_answers_based_on_secant_method_answers_based_on_newton_method_answers_step2)),
        ('Aitken Method answers based on Simple Iteration answers', len(aitkenـmethod_answers_based_on_simpleـiteration_answers_step2))]

        length_of_Aitken_methods = [tup for tup in length_of_Aitken_methods if tup[1] > 0]
        sorted_length_of_Aitken_methods = sorted(length_of_Aitken_methods, key=lambda x: x[1])
        fastest_Aitken_method_step2 = sorted_length_of_Aitken_methods[0] if sorted_length_of_Aitken_methods else "No valid Aitken methods"
        print(f"Fastest Aitken Method: {fastest_Aitken_method_step2}")

        user_plot_choice = input("Do you want to check this as a plot (y/n)? ")

        if user_plot_choice == "y":
            method_names = ["aitken_BM", "aitken_NM", "aitken_SM_a_b", "aitken_SM_BM", "aitken_SM_NM", "aitken_SIM"]
            method_lengths = [tup[1] for tup in sorted_length_of_Aitken_methods]
            df = pd.DataFrame({"lengths": method_lengths, "method_names": method_names})
            plt.figure(figsize=(10, 6))
            sns.pointplot(data=df, x="method_names", y="lengths", join=True, capsize=0.1)
            plt.title("Methods Differences")
            plt.grid(axis='x')
            plt.tight_layout()
            plt.show()

            plt.figure(figsize=(10, 6))
            plt.bar(method_names, method_lengths, color='red')
            plt.title("lengths of Aitken methods", fontsize=14)
            plt.xlabel("Aitken Methods", fontsize=12)
            plt.ylabel("length", fontsize=12)
            plt.xticks(rotation=90, fontsize=10)
            plt.tight_layout()
            plt.grid(axis='y', linestyle='--', alpha=0.7)
            plt.show()
        else:
            print("Alright! Lets continue.")

        if fastest_method_step2 == fastest_Aitken_method_step2:
            print("================================================================================")
            print(f"{fastest_method_step2} is really the fastest!!!!!!!!!")