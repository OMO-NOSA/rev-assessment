import json
from django.urls import reverse, include, path
from rest_framework import status
from django.test import TestCase, Client
from api.models import UserDetails

client = Client()

class UserTests(TestCase):
    def setUp(self):
        self.invalid_payload = {
            'username': 'Joy3',
            'date_of_birth': '1995-03-17' 
        },
        
        self.valid_payload = {
            'username': 'muffin',
            'date_of_birth': '2021-10-09',
        }
        
        self.valid_put_payload = {
            'username': 'muffin',
            'date_of_birth': '2021-10-07',
        }
        
        self.invalid_put_payload = {
            'date_of_birth': '1995-03-17'
        }

    def test_create_valid_username(self):
        response = self.client.post(
            reverse('create'),
            data=json.dumps(self.valid_payload),
            content_type='application/json'
        )
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(UserDetails.objects.count(), 1)
        self.assertEqual(UserDetails.objects.get().username, 'muffin')

    def test_create_invalid_username(self):
        response = client.post(
            reverse('create'),
            data=json.dumps(self.invalid_payload),
            content_type='application/json'
        )
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)

    # def test_put_valid_request(self):
    #     response = client.put(
    #         reverse('edit', kwargs={'username': 'username'}),
    #         data=json.dumps(self.valid_put_payload),
    #         content_type='application/json'
    #     )
    #     self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)
        
    # def test_put_invalid_request(self):
    #     response = client.put(
    #         reverse('edit', kwargs={'pk': self.muffin.pk}),
    #         data=json.dumps(self.invalid_put_payload),
    #         content_type='application/json'
    #     )
    #     self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)