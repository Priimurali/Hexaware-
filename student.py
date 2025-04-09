import pyodbc
 
 
server = 'DESKTOP-9IBBKL9\\SQLEXPRESS'
database = 'Student_Management'
username = ''
password = ''
driver = '{SQL Server}'
 
conn = pyodbc.connect(
    f'DRIVER={driver};'
    f'SERVER={server};'
    f'DATABASE={database};'
    f'UID={username};'
    f'PWD={password}'
)
 
cursor = conn.cursor()
 
def create_student(stu_id,name,age,course):
     cursor.execute("Insert into students(id,name,age,course) values(?,?,?,?)",(stu_id,name,age,course))
     conn.commit()
     print("Student Added!")

def read_student():
     cursor.execute("Select * from Students") 
     for row in cursor.fetchall():
          print(row)

def update_student(stu_id):
     print("\nWhat do you want to update?")
     print("1.Name \n2.Age\n3.Course")
     choice = input("Enter choice(1/2/3):")
     if choice=='1':
          new_name=input("Enter Name:")
          cursor.execute("Update Students set name=? where id=?",(new_name,stu_id))
     elif choice =='2' :
            new_age = int(input("Enter new age:"))
            cursor.execute("Update Students set age=? where id=?",(new_age,stu_id))
     elif choice == '3':
            new_course=input("Enter new course: ")
            cursor.execute("Update Students set course=? where id=?",(new_course,stu_id))
     else:
            print("Invalid Choice!")
            return
     conn.commit()
     print("Student Updated!")

def delete_student(stu_id):
      cursor.execute("Delete from Students where id=?",(stu_id))
      conn.commit()
      print("Student Deleted!")
     
# create_student(1,"Priya",20,"AIDS")
create_student(2,"Sneka",21,"CSE")
create_student(3,"Harish",19,"IT")
read_student()
update_student(2)
read_student()
delete_student(3)
read_student()

