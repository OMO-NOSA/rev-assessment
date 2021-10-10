from django.db.models import fields
from rest_framework import serializers
from datetime import datetime
from api.models import UserDetails

MAX_USERNAME_LENGTH = 50

class UserDetailsSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserDetails 
        fields = ['id', 'username', 'date_of_birth']
        read_only_fields = ['id']
  
    def validate_username(self, username):
        if not username.isalpha():
            raise serializers.ValidationError("Invalid username '{}'. <username> must contains only letters".format(username))
            
        if len(username) > MAX_USERNAME_LENGTH:
            raise serializers.ValidationError("<username> length must be less than {} letters"
                .format(MAX_USERNAME_LENGTH))
        return username
    
    def validate_date_of_birth(self, date_of_birth):
        try:
            dob = datetime.strptime(
                str(date_of_birth), '%Y-%m-%d')
            current_date = datetime.strptime(
                datetime.now().strftime("%Y-%m-%d"), '%Y-%m-%d')
            if dob >= current_date:
                raise serializers.ValidationError("'{}' date must be a date before the today date ('{}')".format(
                    date_of_birth, current_date.strftime("%Y-%m-%d")))
            return date_of_birth
        except ValueError:
            raise serializers.ValidationError("Incorrect data format for '{}' date, should be YYYY-MM-DD".format(date_of_birth))
       


    def create(self, validated_data):
        username = validated_data.get('username')
        if UserDetails.objects.filter(username__iexact=username).exists():
            raise serializers.ValidationError({
                "message": "Username already exits, please choose another"
            })
            
        return UserDetails.objects.create(**validated_data)
    