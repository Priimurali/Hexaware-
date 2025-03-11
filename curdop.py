class ArrayCRUD:
    def __init__(self):
        self.arr = []

    def create(self):
        n = int(input("Enter number of elements: "))
        for _ in range(n):
            self.arr.append(int(input()))
        print("Array created:", self.arr)

    def read(self):
        m=int(input("Enter index to read value:"))
        if m<len(self.arr)-1:
           print("value:",self.arr[m])
        else:
           print("Invalid index")

    def update(self):
        index = int(input("Enter index to update: "))
        value = int(input("Enter new value: "))
        if 0 <= index < len(self.arr):
            self.arr[index] = value
            print("Updated Array:", self.arr)
        else:
            print("Invalid index")

    def delete(self):
        index = int(input("Enter index to delete: "))
        if 0 <= index < len(self.arr):
            self.arr.pop(index)
            print("Array after deletion:", self.arr)
        else:
            print("Invalid index")

# Create an instance of the class
crud = ArrayCRUD()

# Perform CRUD operations
crud.create()
crud.read()
crud.update()
crud.delete()

