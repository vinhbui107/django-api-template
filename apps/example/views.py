import logging

from rest_framework import views, status
from rest_framework.response import Response

logger = logging.getLogger('django')


class Test(views.APIView):
    def get(self, request):
        logger.info("Test info logging")
        return Response(data={"message": "Test API!"}, status=status.HTTP_200_OK)
