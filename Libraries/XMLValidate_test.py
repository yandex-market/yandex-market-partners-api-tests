import unittest
import xmlschema

from Libraries.XMLValidate import xml_validate


class DataTestCase(unittest.TestCase):
    def test_validate_uniq(self):
        xsd_path = "XMLValidateTestData/TestsXSD/uniq.xsd"
        with self.assertRaises(xmlschema.XMLSchemaChildrenValidationError):
            xml_validate("XMLValidateTestData/empty_uniq.xml", xsd_path)

        xml_validate("XMLValidateTestData/only_uniq.xml", xsd_path)
        xml_validate("XMLValidateTestData/only_hash.xml", xsd_path)
        xml_validate("XMLValidateTestData/uniq_and_hash.xml", xsd_path)

    def test_validate_request_state(self):
        xsd_path = "../Data/Responses/Schemas/Delivery/request_state.xsd"
        with self.assertRaises(xmlschema.XMLSchemaChildrenValidationError):
            xml_validate("XMLValidateTestData/empty_is_error.xml", xsd_path)

        xml_validate("XMLValidateTestData/only_is_error.xml", xsd_path)

        with self.assertRaises(xmlschema.XMLSchemaChildrenValidationError):
            xml_validate("XMLValidateTestData/with_zero_errors.xml", xsd_path)

        xml_validate("XMLValidateTestData/with_errors.xml", xsd_path)


class OrdersTestCase(unittest.TestCase):
    def test_validate_create_order_response(self):
        xsd_path = "../Data/Responses/Schemas/Delivery/create_order_response.xsd"
        xml_validate("XMLValidateTestData/create_order_response.xml", xsd_path)

    def test_validate_get_order_response(self):
        xsd_path = "../Data/Responses/Schemas/Delivery/get_order_response.xsd"
        xml_validate("XMLValidateTestData/get_order_response.xml", xsd_path)


class MovementTestCase(unittest.TestCase):
    def test_validate_put_inbound_response(self):
        xsd_path = "../Data/Responses/Schemas/Movement/put_inbound_response.xsd"
        xml_validate("XMLValidateTestData/put_inbound_response.xml", xsd_path)


if __name__ == '__main__':
    unittest.main()
