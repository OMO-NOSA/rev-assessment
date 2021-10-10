from rest_framework import status, generics
from rest_framework.response import Response
from api.models import UserDetails
from api.serializers import UserDetailsSerializer
from rest_framework.decorators import api_view

@api_view(['POST'])
def add_user_details(request):
    if request.method == 'POST':
        serializer = UserDetailsSerializer(data=request.data)
        if serializer.is_valid():
            try:
                serializer.save()
            except Exception as e:
                print(e)
                return Response({
                    "Message": "An error occured"
                }, status=status.HTTP_400_BAD_REQUEST)
                         
            return Response(serializer.data, status=status.HTTP_201_CREATED) 
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['PUT','GET'])
def edit_user(request, username):
    user =generics.get_object_or_404(UserDetails, username=username)
    if request.method == 'PUT':
        serializer = UserDetailsSerializer(user, data=request.data)
        if serializer.is_valid():
            try:
                serializer.save()
            except Exception as e:
                return Response({
                    "Message": "An error occured"
                }, status=status.status.HTTP_400_BAD_REQUEST)
                         
            return Response(status=status.HTTP_204_NO_CONTENT) 
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)   
    
    elif request.method == 'GET':
        days = user.get_days_to_next_birthday()
        if days > 0:
            return Response({'message': "Hello, {}! Your birthday is in {} day(s)".format(username, days)}, status=status.HTTP_200_OK)
        return Response({'message': "Hello, {}! Happy birthday!".format(username)}, status=status.HTTP_200_OK)


@api_view(['GET'])
# API method - Health check
def health_check(request):
    return Response({"Health": "Everything is OK"}, status=status.HTTP_200_OK)