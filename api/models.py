from django.db import models
from django.utils import timezone
from dateutil.relativedelta import relativedelta
from datetime import datetime


#Model for UserDetails
class UserDetails(models.Model):
    username      = models.CharField(max_length=50, unique=True)
    date_of_birth = models.DateField()
    
    
    def get_days_to_next_birthday(self):
        now = datetime.strptime(
            datetime.now().strftime("%Y-%m-%d"), '%Y-%m-%d')
        next_birthday = datetime(
        now.year, self.date_of_birth.month, self.date_of_birth.day)
        diff = next_birthday - now
        if diff.days < 0:
            diff = next_birthday + relativedelta(years=1) - now
        return diff.days
    
    