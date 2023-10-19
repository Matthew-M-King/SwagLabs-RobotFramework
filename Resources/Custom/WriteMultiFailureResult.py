from robot.libraries.BuiltIn import BuiltIn
from robot.api.deco import keyword
from robot.api import logger

class WriteMultiFailureResult():

    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self):
        self.results = None

    @keyword("Log Readable Element Position Failure Result")
    def log_readable_element_position_failure_result(self, results):
        """
        Inserts readable multiple failure result into `log.html` based on given `type`. Need to be used after `Try Assert` keyword

        """
        for result in results:
            chunks = result.split("\n")
            style_block = """
            <style>
                #demo table, #demo th, #demo td {
                    border: 1px dotted black;
                    border-collapse: collapse;
                    table-layout: auto;
                }
            </style>
            """
            
            html_text = f"""{style_block}
            <table id="demo" style="width:100%">
                <tr>
                    <th style="width:50%">Summary</th>
                    <th style="width:25%">Parent Element</th>
                    <th style="width:25%">Child Element</th>
                </tr>
                <tr>
                    <td>{chunks[0]}</td>
                    <td style="text-align:center">{chunks[1]}</td>
                    <td style="text-align:center">{chunks[2]}</td>
                </tr>
            </table>
            """
            logger.info(html_text, html=True)


    @keyword("Log Readable Product Desc Failure Result")
    def log_readable_product_desc_failure_result(self, results):
        """
        Inserts readable multiple failure result into `log.html` Need to be used after `Try Assert` keyword

        """
        for result in results:
            chunks = result.split("\n")
            style_block = """
            <style>
                #demo table, #demo th, #demo td {
                    border: 1px dotted black;
                    border-collapse: collapse;
                    table-layout: auto;
                }
            </style>
            """
            
            html_text = f"""{style_block}
            <table id="demo" style="width:100%">
                <tr>
                    <th style="width:50%">Summary</th>
                    <th style="width:25%">Expected</th>
                    <th style="width:25%">Actual</th>
                </tr>
                <tr>
                    <td>{chunks[0]}</td>
                    <td style="text-align:center">{chunks[1]}</td>
                    <td style="text-align:center">{chunks[2]}</td>
                </tr>
            </table>
            """
            logger.info(html_text, html=True)