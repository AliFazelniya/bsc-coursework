# Ali Fazelniya ID: 4011833230
# Project1: Dining Philosophers Problem Solution With Python And Semaphore (Dijkstra Method)

# Import Essential Libaries (threading for using semaphore and time to show states better)
import threading
import time

# Number of philosophers.
n = 5

# Possible states of philosophers: "Think", "Hungry", "Eat". Use an array to store philosophers' states.
state = []
# At the beginning all philosophers are thinking. so all states are "Think".
for i in range(n):
    state.append("Think")

# Mutex semaphore for ensuring mutual exclusion when accessing shared state 
mutex = threading.Semaphore(1)

# Build a semaphore for every philosopher.
s = []
for i in range(n):
    s.append(threading.Semaphore(0))

# Use modulo n to get left neighbor and right neighbor of philosopher i. we use modulo n cause philosophers seat around a circular table.
# Return the index of the left neighbor of philosopher i (circular table)
def left(i):
    return (i + n - 1) % n

# Return the index of the right neighbor of philosopher i (circular table)
def right(i):
    return (i + 1) % n

# Test function to check if left philosopher i is able to eat or not?
def test(i):
    # Check if state of philosopher i is "Hungry" is he's neighbors' are not eating:
    if state[i] == "Hungry" and state[left(i)] != "Eat" and state[right(i)] != "Eat":
        # If condition is true then philosopher i can eat. so change he's state to "Eat"
        state[i] = "Eat"
        # Then release he's Semaphore
        s[i].release()

# Attempt to take forks (enter critical section, mark as hungry, test for permission to eat)
def take_forks(i):
    # Acquire the mutex to enter the critical section; ensures that only one thread can modify shared state at a time.
    mutex.acquire()
    # Change philosopher i's state to "Hungry".
    state[i] = "Hungry"
    # Print philosopher i's state for announcement to user.
    print(f"philosopher{i} is hungry")
    # Call test function to check philosopher i is able to eat or not.
    test(i)
    # Exit the critical section by releasing the mutex
    mutex.release()
    # Block this thread until the philosopher i is allowed to eat (semaphore will be released in test())
    s[i].acquire()

# Put down forks function. When philosopher i finishes eating; sets state to THINKING and checks if neighbors can eat will be used.
# Put down forks and notify neighbors (set state to thinking, check neighbors)
def put_forks(i):
    # Enter critical section to safely modify shared state
    mutex.acquire()
    # Set philosopher i's state to Think (cause philosopher i done eating)
    state[i] = "Think"
    # Print philosopher i's state for announcement to user.
    print(f"philosopher{i} is thinking")
    # Check if left and right neighbors can now eat (grant permission if possible)
    test(left(i))
    test(right(i))
    # Exit critical section by releasing the mutex
    mutex.release()

# Philosopher routine: Think → Hungry → Eat → Think (infinite loop)
def philosopher(i):
    while True:
        # Show philosopher i is thinking to user.
        print(f"philosopher{i} is thinking...")
        # Create a belay for user's understanding.
        time.sleep(1)
        # Call take forks function.
        take_forks(i)
        # Show philosopher i starts eating to user.
        print(f"philosopher{i} is eating...")
        # Create a belay for user's understanding.
        time.sleep(2)
        # Call put forks function.
        put_forks(i)

# Create and start a thread for each philosopher
threads = []
for i in range(n):
    threads.append(threading.Thread(target=philosopher, args=(i,)))
for t in threads:
    t.start()

for t in threads:
    t.join()