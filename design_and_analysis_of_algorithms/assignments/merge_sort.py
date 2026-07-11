# Ali Fazelniya ID:4011833230
# Merge Sort algorithm in python.
# Merge sort is a divide and conquer algorithm. Steps for this algorithm is according to following steps:
# 1.Divide the unsorted list into n sublists, each containing one element (a list of one element is considered sorted)
# 2.Repeatedly merge sublists to produce new sorted sublists until there is only one sublist remaining. This will be the sorted list.
# In this code we have two functions. One for dividing the main array to sublists(merge function).
# Another function for comparison elements and sorting the array (merge_sort).
# Explanation of merge function: In this function we will build sublists by dividing list to two parts form mid of array. Left part and right part. And when we finished dividing to one element lists, we will call merge_sort function.
def merge(unsorted_array):
    # First Check if the lengths of arrays are higher than 1 or not.
    if len(unsorted_array) > 1:
        mid = len(unsorted_array)//2
        # Dividing to two parts(Sublists)
        left_array = unsorted_array[:mid]
        right_array = unsorted_array[mid:]
        left = merge(left_array)
        right = merge(right_array)
        # Call merge_sort to compare and merge again.
        return merge_sort(left, right)
    else:
        return unsorted_array
# Explanation of merge_sort function: In this function we will receive right and left sublists and compare them with eachother and merge again.
def merge_sort(left_list, right_list):
    # describe to counter for sublists. left_counter counter of left subset and right_counter counter for right subset.
    left_counter = 0
    right_counter = 0
    # Define an empty list to merge.
    sorted_array = []
    len_left = len(left_list)
    len_right = len(right_list)
    # Main loop of comparison. It will count every sublists end compare each element with another elements.
    while left_counter < len_left and right_counter < len_right:
        if left_list[left_counter] <= right_list[right_counter]:
            sorted_array.append(left_list[left_counter])
            left_counter += 1
        else:
            sorted_array.append(right_list[right_counter])
            right_counter += 1
    # These following loops is for the time when length of on sublist is lower than another sublist.With these loops every elements will be merged.
    while left_counter < len_left:
        sorted_array.append(left_list[left_counter])
        left_counter += 1
    while right_counter < len_right:
        sorted_array.append(right_list[right_counter])
        right_counter += 1
    return sorted_array
# Test Array
test_array = [28,11,13,21,26,14,16,23]
print(f"The merged array is: {merge(test_array)}")