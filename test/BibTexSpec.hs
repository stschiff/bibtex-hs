module BibTexSpec (spec) where

import           BibTeX (BibEntry (..), readBibFile, writeBibFile)

import           Test.Hspec

spec :: Spec
spec = do
    testBibReadWriteReadCycle

testBibReadWriteReadCycle :: Spec
testBibReadWriteReadCycle = describe
    "Poseidon.BibFile.readBibTeXFile and Poseidon.BibFile.writeBibTeXFile" $ do
        let testBibFileIn = "test/testDat/test.bib"
        let testBibFileOut = "/tmp/bibFileTest.bib"
        it "reading, writing and reading again should maintain (general) consistcency" $ do
            -- perform actions
            testReferences1 <- readBibFile testBibFileIn
            writeBibFile testBibFileOut testReferences1
            testReferences2 <- readBibFile testBibFileOut

            -- test outcome
            map bibEntryId testReferences1 `shouldMatchList` ["A1971", "B2014", "P2020"]
            map bibEntryId testReferences1 `shouldMatchList` map bibEntryId testReferences2
            map bibEntryFields testReferences1 `shouldMatchList` map bibEntryFields testReferences2
