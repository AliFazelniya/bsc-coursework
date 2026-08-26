class Cylander:
    def __init__(self,r,h):
        self.r = r
        self.h = h
        
    def side_area(self):
        return 2*3.14*self.r**2 + 2*3.14*self.h
       
    def volume(self):
        return 3.14*self.r**2*self.h
        
radius = int(input("Please enter radius of cylander: "))

height = int(input("Please enter radius of cylander: "))

cy = Cylander(radius,height)
print("The side area of this cylander is" , cy.side_area())
print("The volume of this cylander is", cy.volume())
