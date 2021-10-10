from django.urls import path
from api.views import add_user_details, edit_user, health_check

urlpatterns = [ 
    path('createuser/', add_user_details, name='create'),
    path('hello/<str:username>/', edit_user, name='edit'), 
    path('health/', health_check, name='health_check')

]
