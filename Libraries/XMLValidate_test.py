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
        xsd_path = "../Data/Responses/Delivery/Data/request_state.xsd"
        with self.assertRaises(xmlschema.XMLSchemaChildrenValidationError):
            xml_validate("XMLValidateTestData/empty_is_error.xml", xsd_path)

        xml_validate("XMLValidateTestData/only_is_error.xml", xsd_path)

        with self.assertRaises(xmlschema.XMLSchemaChildrenValidationError):
            xml_validate("XMLValidateTestData/with_zero_errors.xml", xsd_path)

        xml_validate("XMLValidateTestData/with_errors.xml", xsd_path)


class OrdersTestCase(unittest.TestCase):
    def test_validate_create_order_response(self):
        xsd_path = "../Data/Responses/Delivery/Orders/create_order_response.xsd"
        xml_validate("XMLValidateTestData/create_order_response.xml", xsd_path)

    def test_validate_get_order_response(self):
        xsd_path = "../Data/Responses/Delivery/Orders/get_order_response.xsd"
        xml_validate("XMLValidateTestData/get_order_response.xml", xsd_path)


if __name__ == '__main__':
    unittest.main()
