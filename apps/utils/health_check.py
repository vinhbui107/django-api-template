from datetime import datetime

from django.http import JsonResponse
from django.views.generic.base import View

started_time = datetime.now()


class HealthCheckView(View):

    def get(self, request, *args, **kwargs):
        return JsonResponse(
            {
                'status': 'OK',
                'started_time': started_time
            },
            status=200
        )
