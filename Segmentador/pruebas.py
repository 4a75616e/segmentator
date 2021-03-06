import unittest
import io
import time
import datetime
import sys
import os

from server import *


class TestUM(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        pass

    @classmethod
    def tearDownClass(cls):
        pass

    def setUp(self):
        self.app = app.test_client()
        # propagate the exceptions to the test client
        self.app.testing = True

    def tearDown(self):
        pass

    # testing de los codigos de estado

    def test_index_status_code(self):
        """Funcion para probar la respuesta al url: /index
        """
        result = self.app.get('/')
        self.assertEqual(result.status_code, 200)

    def test_mostrar_status_code(self):
        """Funcion para probar la respuesta al url: /index
        """
        result = self.app.post('/upload')
        self.assertEqual(result.status_code, 200)
        
    def test_medir_status_code(self):
        """Funcion para probar la respuesta al url: /medir
        """
        result = self.app.get('/medir')
        self.assertEqual(result.status_code, 200)
        
    def test_dice(self):
        """Funcion para probar la funcion que se encarga de calcular
        el coeficiente de Dice
        """
        nom1 = "2_pred.png"
        nom2 = "2_pred.png"
        val = dice_manual2(nom1, nom2)
        self.assertEqual(val, 0.0)
        
    def test_segmentadas_status_code(self):
        """Funcion para probar la respuesta al url: /index
        """
        result = self.app.get('/segmentadas')
        self.assertEqual(result.status_code, 200)
        
    def test_colorear(self):
        """Funcion para probar la funcion que se encarga de calcular
        el coeficiente de Dice
        """
        nom1 = "1_predcol.png"
        nom2 = "1_predcol.png"
        val = dice_manual2(nom1, nom2)
        self.assertEqual(val, 0.0)

    def test_cargar_imagen(self):
        """Funcion para probar las funciones de cargar imagenes
        Simula una peticion POST en la que le envia la imagen perro.jpg
        Solo envia una imagen, su finalidad es detectar
        si la carga de imagenes funciona
        """
        data = {}
        img1 = open('datos\\perro.jpg', 'rb')
        img2 = open('datos\\manzana.jpg', 'rb')
        img3 = open('datos\\rusia.jpg', 'rb')
        data['file'] = [img1, img2, img3]
        # result = self.app.get('/cargar')
        response = self.app.post(
            '/upload', data=data, follow_redirects=True,
            content_type='multipart/form-data'
            )
        print(response.data)
        self.assertEqual(response.status_code, 200)

    def test_cargar_imagenes(self):
        """Funcion para probar las funciones de carga de imagenes
        Simula una peticion POST en la que le envia la imagen perro.jpg
        Envia varias imagenes
        """
        data = {}
        data['file'] = open('datos\\perro.jpg', 'rb')
        # result = self.app.get('/cargar')
        response = self.app.post(
            '/upload', data=data, follow_redirects=True,
            content_type='multipart/form-data'
            )
        print(response.data)
        self.assertEqual(response.status_code, 200)

    def test_segmentar2_status_code(self):
        """Funcion para probar la respuesta al url: /segmentar2
        """
        result = self.app.get('/segmentar2')
        self.assertEqual(result.status_code, 200)

    def test_login(self):
        """Funcion para probar la funcionalidad de login a la plataforma
        Envia un usuario y contrasena de un usuario valido
        Si el login funciona correctamente retorna el codigo 200
        """
        data = {}
        data['usuario'] = 'rodrigo@ucr.ac.cr'
        data['contrasena'] = 'pwd-de-rodrigo'
        # result = self.app.get('/cargar')
        response = self.app.post(
            '/login', data=data, follow_redirects=True,
            content_type='multipart/form-data'
            )
        print(response.data)
        self.assertEqual(response.status_code, 200)

    def test_segment(self):
        """Funcion para probar la funcionalidad de segmentacion
        Envia las imagenes de un directorio de prueba
        y espera que un true sea retornado
        """
        string1 = ("C:\\Users\\Juan\\Desktop\\OneDrive - "
                   "Estudiantes ITCR\\2sem"
                   "\\calidad\\proyecto\\git\\Segmentador\\uploads\\prueba\\")
        string2 = ("C:\\Users\\Juan\\Desktop\\OneDrive - "
                   "Estudiantes ITCR\\2sem"
                   "\\calidad\\proyecto\\git\\Segmentador"
                   "\\uploads\\prueba_results\\")
        with app.app_context():
            a = predict_web_test(string1, string2)
            self.assertEqual(a, True)


if __name__ == '__main__':
    unittest.main()
