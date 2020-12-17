import unittest
import xmlschema

from Libraries.XMLValidate import xml_validate


class DataTestCase(unittest.TestCase):
    def test_validate_request_state(self):
        xsd_path = "../Data/Schemas/Common/request_state.xsd"

        xml_validate("XMLValidateTestData/empty_is_error.xml", xsd_path)

        xml_validate("XMLValidateTestData/only_is_error.xml", xsd_path)

        with self.assertRaises(xmlschema.XMLSchemaChildrenValidationError):
            xml_validate("XMLValidateTestData/with_zero_errors.xml", xsd_path)

        xml_validate("XMLValidateTestData/with_errors.xml", xsd_path)


class OrdersTestCase(unittest.TestCase):
    def test_validate_create_order_response(self):
        xsd_path = "../Data/Schemas/Responses/Delivery/create_order_response.xsd"
        xml_validate("XMLValidateTestData/Delivery/create_order_response.xml", xsd_path)

    def test_validate_get_order_response(self):
        xsd_path = "../Data/Schemas/Responses/Delivery/get_order_response.xsd"
        xml_validate("XMLValidateTestData/Delivery/get_order_response.xml", xsd_path)


class MovementTestCase(unittest.TestCase):
    def test_validate_put_inbound_response(self):
        xsd_path = "../Data/Schemas/Responses/Delivery/put_inbound_response.xsd"
        xml_validate("XMLValidateTestData/Delivery/put_inbound_response.xml", xsd_path)

    def test_validate_get_inbound_response(self):
        xsd_path = "../Data/Schemas/Responses/Delivery/get_inbound_response.xsd"
        xml_validate("XMLValidateTestData/Delivery/get_inbound_response.xml", xsd_path)


if __name__ == '__main__':
    unittest.main()
