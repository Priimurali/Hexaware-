def lin_search(arr,num):
    for i in range(len(arr)):
        if num == arr[i]:
            return i
    return -1
arr=list(map(int,input().split()))
num=4
print(lin_search(arr,num))